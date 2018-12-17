Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D13BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:48:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88AB2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SGhxSSBn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FzHtBQec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88AB2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=RjKK3jstbgHdDejH5zq/O/V2TKRa89ADijZw4WZ/xN0=; b=SGhxSSBn7KNlJC9oXvtuc2Ci/h
	q8ymZJtS+UN2YwukjzeTsn7+tw0mo0jsXwrZw2edesj/IqpaXEfHJcDss0wQz5/dHcTsJCeMlrZUs
	x1RqGns7Rs0FamTaX95wLBj37cc79iGD9sK6ITbZnjaWgZcKy4VGn4SUcjCWzeBDfeCoVc8gsFTHN
	d+JvwKia20MwzRdKns8iLwqf6oXgjBXpcrm+6SzcydVfkAjQCRg04Es65aoouI0bvHMJEYcsA8dmY
	Sw0+C5gXnNjDOpn2ShWsIRQ7GbZ5Cl7xIeettn+uxCgxP5YOgzmEqEJ+uZUeZ9lddlmS4ObKNpqoR
	XFXhOY/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYpVG-0006zK-MC; Mon, 17 Dec 2018 09:47:58 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYpUC-0005qZ-Lu
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 09:46:58 +0000
Received: by mail-wr1-x442.google.com with SMTP id p4so11526808wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 01:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DZnT+i5jw7FKMKXrOSMgnbdLeVWkWYBBUnpyBbjaMIo=;
 b=FzHtBQecwnsOdmLrHWs1fQzYOhp3dfjJ0dhPsVXtjH7IPLKxHLdtL8K99B09iFOjlM
 nKlO/8up0jW8eqbjiOZjUhUdv9/rStEqwSDMqAXIih+cpUEK8huEj4Gk+ybQPCePF8fA
 dPkfbuUPbHOjqKk5/e3mvs5VhMyDoWap7Knr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DZnT+i5jw7FKMKXrOSMgnbdLeVWkWYBBUnpyBbjaMIo=;
 b=gh37vV5FmAI7ChD/nRBq4ZIOyzOFZNmkQ257pJwo+q3Kyj+9FbPDaQntio/DXPKOmo
 Y4VBCXGFbXa5xGUmkwBpmcBIgRgfVQaUCd2XGtZ8ihkNLrUHKnTySxK2vsuZnqjKe/qz
 O/UA/Z+C5Y2AV7F+4gTYvTrf/gD60IWkCXtlgaDsi+ID+GMGEhdPITBKSBNYOUFezz4M
 0h+a587zK88W88btqEZaZIwpRgrwcEKXCYFo6F56+fPKUqtRaaoIY3Tizhq0oSOFgigr
 R/Yo2Z515AC3L9FGmiTMfWYC2T5v6Xxi6HLPG0gWdm41/wm2+VuowpFaH7hLtdjmGuFZ
 OIOA==
X-Gm-Message-State: AA+aEWaO/iI1hByOqxQosV7ZXnS2O1bZYDf4L8zYXwVSp29ont2Qlq01
 UGcw9oAFH/of2nENyTBTsjqd7w==
X-Google-Smtp-Source: AFSGD/W556/G72nW1KLgphiChECIUNEbP+PQ5P/XZO+ldt3E2+Te6cBFOdGtxBOq5cdnXt3oz6dVlQ==
X-Received: by 2002:adf:a4d9:: with SMTP id h25mr9285946wrb.167.1545040000993; 
 Mon, 17 Dec 2018 01:46:40 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.58])
 by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 01:46:40 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 andy.gross@linaro.org, david.brown@linaro.org, sboyd@kernel.org,
 will.deacon@arm.com, mturquette@baylibre.com, jassisinghbrar@gmail.com
Subject: [PATCH 03/13] mbox: qcom: replace integer with valid macro
Date: Mon, 17 Dec 2018 10:46:20 +0100
Message-Id: <1545039990-19984-4-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_014653_053759_88C6083C 
X-CRM114-Status: GOOD (  13.34  )
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
Cc: devicetree@vger.kernel.org, heiko@sntech.de, arnd@arndb.de, olof@lixom.net,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, bjorn.andersson@linaro.org,
 enric.balletbo@collabora.com, vkoul@kernel.org, sibis@codeaurora.org,
 niklas.cassel@linaro.org, horms+renesas@verge.net.au, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org, jagan@amarulasolutions.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use the correct macro when registering the platform device.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index dc8fdab1..b782173 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -108,7 +108,7 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 register_clk:
 	apcs->clk = platform_device_register_data(&pdev->dev,
 						  "qcom-apcs-msm8916-clk",
-						  -1, NULL, 0);
+						  PLATFORM_DEVID_NONE, NULL, 0);
 	if (IS_ERR(apcs->clk))
 		dev_err(&pdev->dev, "failed to register APCS clk\n");
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
