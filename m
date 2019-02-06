Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABF0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:37:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74EBF217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b6B1Mmv7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TzokPaG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EBF217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fmG2v3AQfh0AJZI8I7hkt1E1Xh3J7jY55knZJ7Ab6l8=; b=b6B1Mmv75vuVgO
	Ik0XtpIvYgljuH+JG6Nvnct5KlKhnW+rnIWDFY7qFk7dMj3K7KMxJQ/JDhm0SGKSOEs9cZyDq17R9
	e58Chq/eJ7tNjNfZQbiyLC0TRj1Ox456dqofjgRHw9lLajCvCspmbjj+mQ90RgKPINUAty5Ug2zus
	3phWPdViK57mtMRmJtv5s2mGszKBt/6Gb/yMTAC24EHAY3xgQhL+Zqk4LjE3zGedernoL5shgBX1Z
	TxWY/FVgs1ExKuAtv1lKsB0wRQOH7Q8DVR/iYXAmlwCt44VCshi4KTezgNCvVlqlwiHOUeBycEZhc
	w0LpdymYxtwvl/2x50DQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grOKh-0006uk-C2; Wed, 06 Feb 2019 14:37:47 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grOKd-0006u6-GP
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 14:37:45 +0000
Received: by mail-wr1-x443.google.com with SMTP id z3so7834569wrv.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 06:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lypDSreTF0NpbYbE6e4ptHTBd1wuQq7wAXpNTueGgy0=;
 b=TzokPaG7f1uOuTh3LAqqLUqrOXwTzfAWdGFYOGbpGn0//iR+Bn4+sYOe9QMEOzlMbF
 H7WYszyCZwKjzEL2kaWySutrMCAcfHLdEMHOi567/E8o1ccSUibnzRPYLoKX4HlMf2FL
 ssBPTANl1P60p94240Ef2ZnlYKfNhQFlJ1LHBgle1B76vyaZdpFUQJSrs8mpT1Fcc9MW
 uZICSkTVhOIybtj9NvTWINl7LDI5pXgGrnJpdvK1jq/f9BI2ytr5kv2AojsgCROAtvRS
 z6G89atJgQDRQfEg+hG/y65+KafF2L1naDzXQKvtXD18t2tDXynmOC/NT1a7l4OKprMn
 Nd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lypDSreTF0NpbYbE6e4ptHTBd1wuQq7wAXpNTueGgy0=;
 b=mfRQx4Ymagu/khY+juwUFpDL9OSfdzkfNL3w/fFpGXa7ctv+dY0TSo6TlqLYKXztKi
 WTFTLxNY79l7vqWTmUONjQlzFOdIQyoUFOJZQWxTiXvp9u7VyEIONwUQ3AGJFG4YKOvI
 1D6cwyIHdccVQDbBKg4cR3cf6gsF5QBRcdenYOiabwZ17CrMKTHtOKcg9OTcLg22dwQL
 ZhHsF5CwpVqHLTePfKbRa9eKL5q8M7k+F+Lob/G03Qrk5MrltsKAJkUEUZvlojj3HPLG
 8rwB38YYpA9DnzJbkCEQgggkgqpR/GXWbxC8j/yVA7cBieRUsTy29hMY1e2Mi+fjFxZ6
 fYpQ==
X-Gm-Message-State: AHQUAuanh0gwe3sAnffOk0qohD2l6QSoDfy28nZw7TwxDZSF0UpkKDYt
 V4j5I195tXIBpZZ5wpZzOw+i+Q==
X-Google-Smtp-Source: AHgI3IZdEmZIqL0iexVDY+SvKxpVoibW7uQlS+CR4Dz9u6Zlq1ezMemrh/hq9VZL4Tk2n5sqnDZnfQ==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr7855825wru.33.1549463861875;
 Wed, 06 Feb 2019 06:37:41 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id q8sm23249382wrr.9.2019.02.06.06.37.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Feb 2019 06:37:41 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: catalin.marinas@arm.com, will.deacon@arm.com,
 linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
 kernel@pengutronix.de, fabio.estevam@nxp.com, abel.vesa@nxp.com,
 l.stach@pengutronix.de
Subject: [PATCH] arm64: defconfig: Add IMX2+ watchdog
Date: Wed,  6 Feb 2019 14:37:37 +0000
Message-Id: <20190206143737.25368-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_063743_679359_716A1273 
X-CRM114-Status: UNSURE (   9.64  )
X-CRM114-Notice: Please train this message.
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It's needed to properly reboot the i.MX8MQ EVK board.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 788773d16c7c..1c26d8bfd927 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -423,6 +423,7 @@ CONFIG_UNIPHIER_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
+CONFIG_IMX2_WDT=y
 CONFIG_MESON_GXBB_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=m
 CONFIG_RENESAS_WDT=y
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
