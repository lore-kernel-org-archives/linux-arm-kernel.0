Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996C5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:39:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687C8206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LdJwzEcI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7MVZcmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687C8206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d9EIxx8y4uht8flKb+KiwMEXbktDHlciceVl4fH0dFI=; b=LdJwzEcI4xLN+6
	HC9f3vnSX2sbinpQItXJfavwMbgJLUW9d9X1kdhOMfsMj4StoP6DrCJNwCqMhp/UKjgyvpqnQHW7s
	SnehmFFDZw/IpxI8c6oKEzHGjCqn6e0+6Vi4XpO8/7Ym+orToCFGz7tT4UIKcM9rtKN+VBVOFMNnm
	ncqTRp4Tkj+oMEIX85lrt3idwyOAjSJWwKfYIPjxEDE/k8GkejRFkBWZw9thKaVNriPl+wXw2wOks
	gW09JxwwmTjWNXc2jy3c169MVhZtRYQmxCexpmKZL+viNMrOvHvbQcem/Fz9z7rEIT9fDhKpPnK0g
	n7/B7oZuyUmLrxWRG/lw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYioO-0006ES-So; Mon, 17 Dec 2018 02:39:16 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYioA-00062I-AU
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 02:39:03 +0000
Received: by mail-pg1-x544.google.com with SMTP id d72so5348889pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 18:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nS8g9CvGS33gTXh86smptBvZsHuEs2BP+CgzydNvE9M=;
 b=o7MVZcmK6/qVajV3whHRlwxEsGSJ0GbZl1JJYGbURqkT/qji3x8UdETBtI6n6rSuUr
 T/uzBYZfk8dJqUCfFDaAcS75oNakc/2GABUbGSvtOXTeTLMFS7WV5aZ7U9GrPXUlS4A5
 fWxijv1srVUR6OuU2WVTCsPYQLegVBAP/VVjLqCm0AhqOG4xlUrZlB9AErOv4hQAyjy6
 1xNNqJdt8rkFZGs62hSx5kwyn2GqN6pqKd7TDppVqGwI1Pt2ZYdgpJfjpFguLs3wzdxs
 VdblS2kFBA/wkFlFbUWPiUqwVnDQOzVDpHesDSxzXUQbITAkEuO6dclipieRoaQmVxDQ
 VTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nS8g9CvGS33gTXh86smptBvZsHuEs2BP+CgzydNvE9M=;
 b=rbZCmrz21aEZ0lV+sNF//Pal/kQ1brg76D/6tdiMxDxvSoJz79Foxp5WR87hP6akIe
 xf1210TvRID7YsYvw4FZAtsQ5qHg9Z+Plt6Q0+Fo9tTWE4jzyVK2StbLMVdGzgB6z+0W
 JWmfiYszyTNKbhLVRGA7jp/V3LAsMBJZvrm0layAT1EeATNYRYfusKUHka2TaIGUdCsT
 eNDJlWR+coDdJ5Ljzwc6r+5V4Rj++Mco7Pf/iXGid90/ZRBKSCl8QRh6GkClXkU9buQt
 VLzDUfBfMeKYl9aj86VjfbruBwTjfzAn2NF6rOjlSX5lNAugfRqQ6MGccmIWYa2yhj0N
 bmgw==
X-Gm-Message-State: AA+aEWbUW9KZxw1PY7B35lm0yTqN6L0nXag1+y79fdl8xQjDSzRDUxP5
 jgBiqgHwC/utL9usjUF+rGw=
X-Google-Smtp-Source: AFSGD/VYJ3WZkw0gF3Q5fDERLIrFBpizsTq1T4nFno6+pxR1OytVRHLPTdPvbSHl6up/XIF/ujxiwQ==
X-Received: by 2002:a62:29c3:: with SMTP id
 p186mr11512280pfp.117.1545014331325; 
 Sun, 16 Dec 2018 18:38:51 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id b26sm23129781pfe.91.2018.12.16.18.38.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 16 Dec 2018 18:38:50 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] reset: imx7: Add plubming to support multiple IP
 variants
Date: Sun, 16 Dec 2018 18:38:25 -0800
Message-Id: <20181217023827.7947-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181217023827.7947-1-andrew.smirnov@gmail.com>
References: <20181217023827.7947-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_183902_356855_1FB3106E 
X-CRM114-Status: GOOD (  15.31  )
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
 linux-imx@nxp.com, p.zabel@pengutronix.de,
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
