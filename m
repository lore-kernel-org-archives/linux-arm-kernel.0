Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CC4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:10:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00BE2083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l3753fSd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nRlgadly";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hpk3EXjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00BE2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+ACdPi2QEIynzCZOy9LJYKrIgMBMK3c3qqK91vWl0HY=; b=l3753fSdiRC5LY
	IwOPzxabuuj3ot6t/9C8pNeEv9WlYwaty7ofFQuYQijlhgZ+TTxx1QELvUvsWo2MeFkQQslUoHPKg
	GwcvA/nCHODeOVb9xspkE+xOi+Bp6w9yWfi2vStaNtGPu8wyGDQXbsTbQ1r72JZ2VhQGQ8wUrVzoV
	IjmjzOUEFjDpTILQtUEEuOVhgPyTAVsXmVXVvsCitX+3g7sOLe2XiRJQNvRXAD/3PkwGlJH+yE8pI
	XeYGmIhPylFAOK5CfrJDo+AKR9+X8ZrNow3RXQws5B5t6rZxWDUWSq25cDAUW07JK3n/FwRbyPb2b
	1IJhABnBEACW6Zi76MMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqvu-0005ai-51; Thu, 21 Feb 2019 16:10:46 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqvr-0005aI-Rb
 for linux-arm-kernel@bombadil.infradead.org; Thu, 21 Feb 2019 16:10:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FipZr1PzKuQJl1qKT0T1UxV+PsiN09U6vluBtBA1GLs=; b=nRlgadlyHj9LvDOSv+GQZFaTVo
 AJ38CsrM2tPVRAudGkZYv990yhUmvWPVw02Zb18KKT6bSEoNhj5zFueIiT/hehAD9npp/+4+xz3F9
 Z4mR5cWT4jjuawJ3lUhILqS3Ryfe+LmJlsByJlVLOWpDYCM+LQ+TVoTbCfEW/iTLngMa6fNXnBKAR
 1hw0MNwx4mKFBOHPZTEuoh9xKifFX0u0F4+BrNLuGNA4uj9ARnD77oIe/FUzcwPMcGnwXlMn4jtAd
 f3h17O9yT3GwUFY51jbsja440YBOqvqM+qNUm1LrmlIwiZrFg23DP/0c+cvPi4ucInP8hApJpLX1z
 wSy1AzoQ==;
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqYF-0002BK-Ak
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:46:20 +0000
Received: by mail-lj1-x243.google.com with SMTP id s5-v6so24330180ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FipZr1PzKuQJl1qKT0T1UxV+PsiN09U6vluBtBA1GLs=;
 b=Hpk3EXjQlE8cG9rT3tHsQA+3OGA7djd1QJB+tPozpaAdsKTNRSMIJTc17meyrFs3dw
 z7jasyR+Ts2cMhcX2YqUG3kiR2ZTrnyBlmq5PDRYWDWv0jaCzzR+l+ZSW/rkLLDu3NPl
 CdrFLkovlasST8+Mur0Q/5A51pegt+5ENonN4iAEj1Cs09uVcKlWHLx3nwwklqyGcglo
 FRjEVSDSqfffVMJqEUTRNG2j+5SoRmGtOHzfaSMMIkeMyjfs1gQeZUzuWoTdk5AHyxwz
 VCnzSOzNw96J1WLGEXCYJ3TiHRA1NZX2z8JTz0Sz81lEXn8q/RCaqKxlMh1wCWm/Bni6
 fl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FipZr1PzKuQJl1qKT0T1UxV+PsiN09U6vluBtBA1GLs=;
 b=gRosCUL1aghLevRKvD85B8INHM4LhCnBeOHWXxasliFGa0e3f9sjOgR4+7uudEUQjP
 kXiAIqtKL3cBAG9X8QvHIB69e8JY9dsRQPI5OFch5dGTnQD9aqGQ7pcRdmhVe35k4LC/
 59/owuea/rLItnVxGUdPJQ8zOGDee6lxDUHZAFRwxO1BjM8uOsl6wtWmSeDfIhuI8kFJ
 Sc1/TxS2r4tCLVjJwY2OvJTGM3Gi2CwpNZ5tUSexvQLbJw/xcxtUupLjPqKMuT6oH6lo
 kC7K/M4BYrLCaeXWo4ZSLEM30eY6J8N8wyGFeZUkI0kFa6cmlUgwnnKBr+Ih5iQK+Si6
 hsnQ==
X-Gm-Message-State: AHQUAuaiVgKmqFNZcXy1L7jhxXJ4OQDXS0qJt6sPMOtxT7JM7sKCYVnf
 dNhjDTfCcWSox1e5w13Zt1Jk4ulNuGs=
X-Google-Smtp-Source: AHgI3IYeiWakzLi5p68HYAN0tJG501oXpNunsQbhyQt+iSLOpviffXCAHWu7looOviZX2cEcb3UaZg==
X-Received: by 2002:a2e:9793:: with SMTP id y19mr2280180lji.194.1550763976664; 
 Thu, 21 Feb 2019 07:46:16 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.46.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:46:15 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 27/30 v2] soc: ixp4xx: npe: Add DT probe code
Date: Thu, 21 Feb 2019 16:44:55 +0100
Message-Id: <20190221154458.23763-28-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_104619_416019_6D124959 
X-CRM114-Status: GOOD (  14.54  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This makes the NPE driver able to probe from the device tree.
It only needs to get three memory resources and the plaform
device provide these, so all is pretty simple.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/soc/ixp4xx/ixp4xx-npe.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/ixp4xx/ixp4xx-npe.c b/drivers/soc/ixp4xx/ixp4xx-npe.c
index d2dd916816d4..15979d4376ab 100644
--- a/drivers/soc/ixp4xx/ixp4xx-npe.c
+++ b/drivers/soc/ixp4xx/ixp4xx-npe.c
@@ -729,9 +729,17 @@ static int ixp4xx_npe_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ixp4xx_npe_of_match[] = {
+	{
+		.compatible = "intel,ixp4xx-network-processing-engine",
+        },
+	{},
+};
+
 static struct platform_driver ixp4xx_npe_driver = {
 	.driver = {
 		.name           = "ixp4xx-npe",
+		.of_match_table = of_match_ptr(ixp4xx_npe_of_match),
 	},
 	.probe = ixp4xx_npe_probe,
 	.remove = ixp4xx_npe_remove,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
