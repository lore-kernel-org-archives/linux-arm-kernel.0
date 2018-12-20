Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB475C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:08:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A7B2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NgNKgBEU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOnBZRDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A7B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d9EIxx8y4uht8flKb+KiwMEXbktDHlciceVl4fH0dFI=; b=NgNKgBEUCz1lZW
	iWNbZ8cOOfiFJc/HLmDcbu3YWEPYmVrdGxWK8lFNU+eOJC81stOlRkmBMCPrsIxSOyjQhq+IYaJvK
	47TovapFdwgy0ls7oQLBS6z/Pu0oH0vOcLTRggz/lqCEcDPnao8n/20ej3PXy0sOxCd4NwzafZfqA
	Ca+M5C4vP6/FaKqUn7YhGu694Sbfw/FXnRktcV8UWRVIQSw2TXTVdqX3264yi80V3VcDGzN+kAMnv
	z/dlfcRIO/9IqCDaom1sbse2D1iCvqgfCX1J1D9ZPTXGGu2HvqGzJAgGDRqk2g5HslkpWv1SsPotM
	IYV+lDf1K9iBt2Jwqmeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZmos-0005nl-6D; Thu, 20 Dec 2018 01:08:10 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZmoE-0005H7-Bc
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 01:07:33 +0000
Received: by mail-pg1-x544.google.com with SMTP id m1so26360pgq.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 17:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nS8g9CvGS33gTXh86smptBvZsHuEs2BP+CgzydNvE9M=;
 b=eOnBZRDpT7b8fmJr92MP2Lz83R94nlmqDkHvjOX7a/BcD+2f8tV4CmPREi2BYsiNB1
 xEwcxq0dEV4MuCI9Q5A05XCVy8LU1RcwhVtL/Hs2WUWj4t2hkaOB0qyX3c5bZgy534BT
 ibN84Wh+ZZs/Bnl34uQDuM0pt5mZB1sd7Fqs9b5NWy9SPdSdMggmvzW520TSjUwGBQVy
 oCuCEj5SmEGB6av+obvDcrHdWZEORgPXljfo/Py5wD7xB3O2QYWgksNL4M06rYeee8mH
 OMgBitI0fg8ZcFt0rQUL2XwnyDYQCysmIqMWsbzbgQid97KjB/qkRXe808OzjBtPmf1G
 DBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nS8g9CvGS33gTXh86smptBvZsHuEs2BP+CgzydNvE9M=;
 b=AkBy94gtAYThoy02Hmmhq8pXV1OVCxyAi1EAGEP0wiZ8uuWbHUkocWU8vMOg5PTjAU
 8U1lcPv2lpgmDx7zLfWPx+Ooenauiq09K7FX+2i2dzC0pkqw6uWvqoEWqMrMqP9QlNZV
 onGTMSIpl8oG55A3cJV6VEf3M1UlXKhb/nOGiy8t+TaimSgy+KpKNnWv/aSwLwwT0qt6
 45JDVsq9M5P7eDFYB6pZI2TEy0CGxeVN+X9Napoy/cHAgo/m3KXKm9ZMpc8HCTaWaIp8
 MJczSgHBFPn2DWeMMvdD297nwPyJ2kFVDdZWdj16lGhtj0vLVFxksp3MqJpf59dRqjAa
 7yfA==
X-Gm-Message-State: AA+aEWYnO+UtGNMhgXt0xQWu4c83apa5B5+lyW1mge1GE793wgY2Mu8Z
 19xIk/WPnsLPP/n3O2n5jHs=
X-Google-Smtp-Source: AFSGD/U7PYPVcI2+J6ql5XEoP5OJ89oe5vha4fDfzngRpRSXUZSKm4T+sAtETzeDeotxr8m9oej5hA==
X-Received: by 2002:a63:7a09:: with SMTP id v9mr19946476pgc.112.1545268041114; 
 Wed, 19 Dec 2018 17:07:21 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id 83sm29008612pgf.57.2018.12.19.17.07.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Dec 2018 17:07:20 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: p.zabel@pengutronix.de
Subject: [PATCH v4 1/3] reset: imx7: Add plubming to support multiple IP
 variants
Date: Wed, 19 Dec 2018 17:06:58 -0800
Message-Id: <20181220010700.8598-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181220010700.8598-1-andrew.smirnov@gmail.com>
References: <20181220010700.8598-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_170730_456913_3E91094F 
X-CRM114-Status: GOOD (  15.78  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In order to enable supporting i.MX8MQ with this driver, convert it to
expect variant specific bits to be passed via driver data.

Cc: p.zabel@pengutronix.de
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/reset/reset-imx7.c | 62 +++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 77911fa8f31d..3a36d5863891 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -17,14 +17,29 @@
 
 #include <linux/mfd/syscon.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/regmap.h>
 #include <dt-bindings/reset/imx7-reset.h>
 
+struct imx7_src_signal {
+	unsigned int offset, bit;
+};
+
+struct imx7_src;
+
+struct imx7_src_variant {
+	const struct imx7_src_signal *signals;
+	unsigned int signals_num;
+	unsigned int (*prepare)(struct imx7_src *imx7src, unsigned long id,
+				bool assert);
+};
+
 struct imx7_src {
 	struct reset_controller_dev rcdev;
 	struct regmap *regmap;
+	const struct imx7_src_variant *variant;
 };
 
 enum imx7_src_registers {
@@ -39,10 +54,6 @@ enum imx7_src_registers {
 	SRC_DDRC_RCR		= 0x1000,
 };
 
-struct imx7_src_signal {
-	unsigned int offset, bit;
-};
-
 static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
 	[IMX7_RESET_A7_CORE_POR_RESET0] = { SRC_A7RCR0, BIT(0) },
 	[IMX7_RESET_A7_CORE_POR_RESET1] = { SRC_A7RCR0, BIT(1) },
@@ -72,17 +83,11 @@ static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
 	[IMX7_RESET_DDRC_CORE_RST]	= { SRC_DDRC_RCR, BIT(1) },
 };
 
-static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
+static unsigned int
+imx7_src_prepare(struct imx7_src *imx7src, unsigned long id, bool assert)
 {
-	return container_of(rcdev, struct imx7_src, rcdev);
-}
-
-static int imx7_reset_set(struct reset_controller_dev *rcdev,
-			  unsigned long id, bool assert)
-{
-	struct imx7_src *imx7src = to_imx7_src(rcdev);
-	const struct imx7_src_signal *signal = &imx7_src_signals[id];
-	unsigned int value = assert ? signal->bit : 0;
+	const unsigned int bit = imx7src->variant->signals[id].bit;
+	unsigned int value = assert ? bit : 0;
 
 	switch (id) {
 	case IMX7_RESET_PCIEPHY:
@@ -95,10 +100,32 @@ static int imx7_reset_set(struct reset_controller_dev *rcdev,
 		break;
 
 	case IMX7_RESET_PCIE_CTRL_APPS_EN:
-		value = (assert) ? 0 : signal->bit;
+		value = assert ? 0 : bit;
 		break;
 	}
 
+	return value;
+}
+
+static const struct imx7_src_variant variant_imx7 = {
+	.signals = imx7_src_signals,
+	.signals_num = ARRAY_SIZE(imx7_src_signals),
+	.prepare = imx7_src_prepare,
+};
+
+static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct imx7_src, rcdev);
+}
+
+static int imx7_reset_set(struct reset_controller_dev *rcdev,
+			  unsigned long id, bool assert)
+{
+	struct imx7_src *imx7src = to_imx7_src(rcdev);
+	const struct imx7_src_variant *variant = imx7src->variant;
+	const struct imx7_src_signal *signal = &variant->signals[id];
+	const unsigned int value = variant->prepare(imx7src, id, assert);
+
 	return regmap_update_bits(imx7src->regmap,
 				  signal->offset, signal->bit, value);
 }
@@ -130,6 +157,7 @@ static int imx7_reset_probe(struct platform_device *pdev)
 	if (!imx7src)
 		return -ENOMEM;
 
+	imx7src->variant = of_device_get_match_data(dev);
 	imx7src->regmap = syscon_node_to_regmap(dev->of_node);
 	if (IS_ERR(imx7src->regmap)) {
 		dev_err(dev, "Unable to get imx7-src regmap");
@@ -138,7 +166,7 @@ static int imx7_reset_probe(struct platform_device *pdev)
 	regmap_attach_dev(dev, imx7src->regmap, &config);
 
 	imx7src->rcdev.owner     = THIS_MODULE;
-	imx7src->rcdev.nr_resets = IMX7_RESET_NUM;
+	imx7src->rcdev.nr_resets = imx7src->variant->signals_num;
 	imx7src->rcdev.ops       = &imx7_reset_ops;
 	imx7src->rcdev.of_node   = dev->of_node;
 
@@ -146,7 +174,7 @@ static int imx7_reset_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx7_reset_dt_ids[] = {
-	{ .compatible = "fsl,imx7d-src", },
+	{ .compatible = "fsl,imx7d-src", .data = &variant_imx7 },
 	{ /* sentinel */ },
 };
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
