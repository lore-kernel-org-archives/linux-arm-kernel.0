Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F125C37122
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:11:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD5320870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R2HjBQns";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwN2kjzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD5320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nple/wVAn8a71eQeSy+LwSsaiQ08A2W9Ow1bsM9cunI=; b=R2HjBQnsuWFno6
	D7X3zFD68aKrg/IIGgkv/XgI6/aE51q9DRvZwK200M8tkn/u5HYX8dUdBgnbwVCTuVKOvUHVsxdFZ
	UusAHJdxxabtGiZVOX2qtyUePXrxIBaL6hqJ/9RXhFqqp/nkaanW1DjzeX0Esr0DC4gC0/ZF+c4GH
	Nlb/4fhd5QMtR9YXEcxQmlV+HwI3GDG9lCZxGTgGLXoxhXi3LCxE9zwafVQTHQnxlWlUwDcHt9sLr
	Ljmu42qdyX3RrARVb6jq1F51sRBSS2cEmstLBiDruFpZsHOAreOxs+qltXmxeUxG5rvw5ZM/cbrqp
	Njdvgul78JZzB220Maug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gllXB-0006Ya-R1; Tue, 22 Jan 2019 02:11:25 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gllWs-0006I4-Qa
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 02:11:08 +0000
Received: by mail-pf1-x442.google.com with SMTP id q1so10963987pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 18:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pnZUx9XxqHMk3snYHuOBwaNuTfH4gj67xCuvojOFsmM=;
 b=YwN2kjzm1F3DrbKw8EOucGGzxpFsixUiz2rWuDsGln7h6FnSGb3LmEfR2Iy55qmyAE
 U2Zdvro9gXXKMOg5qU6KzYiRIshLUZHFdcJiBRPX3DTdQSxYVKkOcsa5sfYV0TaBo9w3
 KsGpfhQyvuoCi4ZZXimzN7iBEL31yLfGgZRTe+5hYRSQc0kiFK0xuBZtzUnGLshui8J1
 vee7wPWaZj03US8Ue8VbownCvowg6aHTZCd0SJANwPvDAYAk79APnPx1ZbNmIOconG16
 0J89WMQGRfss9x6MqjCNVErbj0BwJAvVwNcxhc4WQcKWMbIqtDXidcLjaZ5WNV8u51y7
 ykGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pnZUx9XxqHMk3snYHuOBwaNuTfH4gj67xCuvojOFsmM=;
 b=E1lwWPXd+1t/b3zuNQaMPxBdOEezQLwAlgzz7QLgvF7b47oM8t20cXDm1HwYsrzo9p
 HOz89GKAh4BM6IoQwQ7dpTF/HX8MBNwMpnJ1JUHwyaGYXurdbPWitgoNZ1Luq9Mpi2SX
 lhpNAoIo7ab4w+rsFxS+j3JAGtv+M/44EPd1GTMNNGm06XaFNbhYBQhnqP8ubEXNbO8e
 W3pzMFmi1t5ZJlnt3WkdCgv38KxyBXxirIcq972EnUXT2bCnq6dLVF0oVJgLXG+80DwP
 bW+qhjEIgMPt8SympVORnH4DCD3f0lb0mxoIWDPi8kkRpPYAV8QpBu0wJ/X5OjN08iBE
 Udhw==
X-Gm-Message-State: AJcUukfO8rz12QyzT0kZRUwci/tcbMV8lYHKwpHCyizKlfJUpX4ig9d6
 Og58Y49LXmqVuKhhnOzbPQs=
X-Google-Smtp-Source: ALg8bN58U0fAmlsCx0QNK24woKhwYnCON78wVHE0oOQhqizrGw/ZzWAMmmjouGua/ETzSB6W0EiElA==
X-Received: by 2002:a63:f515:: with SMTP id w21mr29947169pgh.220.1548123065130; 
 Mon, 21 Jan 2019 18:11:05 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id c7sm19907267pfh.18.2019.01.21.18.11.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 18:11:04 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: p.zabel@pengutronix.de
Subject: [PATCH v5 1/3] reset: imx7: Add plubming to support multiple IP
 variants
Date: Mon, 21 Jan 2019 18:10:41 -0800
Message-Id: <20190122021043.25449-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122021043.25449-1-andrew.smirnov@gmail.com>
References: <20190122021043.25449-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_181106_915667_35A0C3D7 
X-CRM114-Status: GOOD (  14.78  )
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
 drivers/reset/reset-imx7.c | 50 +++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 77911fa8f31d..cb6e3bc4acc1 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -17,14 +17,26 @@
 
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
+struct imx7_src_variant {
+	const struct imx7_src_signal *signals;
+	unsigned int signals_num;
+	struct reset_control_ops ops;
+};
+
 struct imx7_src {
 	struct reset_controller_dev rcdev;
 	struct regmap *regmap;
+	const struct imx7_src_signal *signals;
 };
 
 enum imx7_src_registers {
@@ -39,9 +51,14 @@ enum imx7_src_registers {
 	SRC_DDRC_RCR		= 0x1000,
 };
 
-struct imx7_src_signal {
-	unsigned int offset, bit;
-};
+static int imx7_reset_update(struct imx7_src *imx7src,
+			     unsigned long id, unsigned int value)
+{
+	const struct imx7_src_signal *signal = &imx7src->signals[id];
+
+	return regmap_update_bits(imx7src->regmap,
+				  signal->offset, signal->bit, value);
+}
 
 static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
 	[IMX7_RESET_A7_CORE_POR_RESET0] = { SRC_A7RCR0, BIT(0) },
@@ -81,8 +98,8 @@ static int imx7_reset_set(struct reset_controller_dev *rcdev,
 			  unsigned long id, bool assert)
 {
 	struct imx7_src *imx7src = to_imx7_src(rcdev);
-	const struct imx7_src_signal *signal = &imx7_src_signals[id];
-	unsigned int value = assert ? signal->bit : 0;
+	const unsigned int bit = imx7src->signals[id].bit;
+	unsigned int value = assert ? bit : 0;
 
 	switch (id) {
 	case IMX7_RESET_PCIEPHY:
@@ -95,12 +112,11 @@ static int imx7_reset_set(struct reset_controller_dev *rcdev,
 		break;
 
 	case IMX7_RESET_PCIE_CTRL_APPS_EN:
-		value = (assert) ? 0 : signal->bit;
+		value = assert ? 0 : bit;
 		break;
 	}
 
-	return regmap_update_bits(imx7src->regmap,
-				  signal->offset, signal->bit, value);
+	return imx7_reset_update(imx7src, id, value);
 }
 
 static int imx7_reset_assert(struct reset_controller_dev *rcdev,
@@ -115,9 +131,13 @@ static int imx7_reset_deassert(struct reset_controller_dev *rcdev,
 	return imx7_reset_set(rcdev, id, false);
 }
 
-static const struct reset_control_ops imx7_reset_ops = {
-	.assert		= imx7_reset_assert,
-	.deassert	= imx7_reset_deassert,
+static const struct imx7_src_variant variant_imx7 = {
+	.signals = imx7_src_signals,
+	.signals_num = ARRAY_SIZE(imx7_src_signals),
+	.ops = {
+		.assert   = imx7_reset_assert,
+		.deassert = imx7_reset_deassert,
+	},
 };
 
 static int imx7_reset_probe(struct platform_device *pdev)
@@ -125,11 +145,13 @@ static int imx7_reset_probe(struct platform_device *pdev)
 	struct imx7_src *imx7src;
 	struct device *dev = &pdev->dev;
 	struct regmap_config config = { .name = "src" };
+	const struct imx7_src_variant *variant = of_device_get_match_data(dev);
 
 	imx7src = devm_kzalloc(dev, sizeof(*imx7src), GFP_KERNEL);
 	if (!imx7src)
 		return -ENOMEM;
 
+	imx7src->signals = variant->signals;
 	imx7src->regmap = syscon_node_to_regmap(dev->of_node);
 	if (IS_ERR(imx7src->regmap)) {
 		dev_err(dev, "Unable to get imx7-src regmap");
@@ -138,15 +160,15 @@ static int imx7_reset_probe(struct platform_device *pdev)
 	regmap_attach_dev(dev, imx7src->regmap, &config);
 
 	imx7src->rcdev.owner     = THIS_MODULE;
-	imx7src->rcdev.nr_resets = IMX7_RESET_NUM;
-	imx7src->rcdev.ops       = &imx7_reset_ops;
+	imx7src->rcdev.nr_resets = variant->signals_num;
+	imx7src->rcdev.ops       = &variant->ops;
 	imx7src->rcdev.of_node   = dev->of_node;
 
 	return devm_reset_controller_register(dev, &imx7src->rcdev);
 }
 
 static const struct of_device_id imx7_reset_dt_ids[] = {
-	{ .compatible = "fsl,imx7d-src", },
+	{ .compatible = "fsl,imx7d-src", .data = &variant_imx7 },
 	{ /* sentinel */ },
 };
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
