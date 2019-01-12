Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E75C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:56:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C302820870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UHczk5dr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmjLQqeN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C302820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KK2sCioJ2Lhk2XaN3kKbjNEPRavoHYVus4/agnhwNp0=; b=UHczk5dr1ObWIW
	yrkvXEUu8XD93CI3FlvG5mcaOnmktqrV+wOQCoj/glNlIuTvgANIMzOPxBbVRfaDIuz8Ov62BgmZe
	3d8fYG0oRepoaNyOyN3QGIAMTuYinU7Sohjfb51xNVpU3DKHo8nnFtALBSt7eqCcM6F1+ph243eU9
	E4Uzh5OoJ5Ap6Ie2kquvY2/76NVEgxay/9rd2fCPK3HjZg0wo23DhCHqgUzW4n9+hCrA2DhO25zFe
	6alMVeodv5gDmEboaFpxg/SX/whiEKzr4M6GzvHefgdZkMUUgc02Zw1evnNMGSQ+ZhrMir2l9uA6w
	Bp8n5XjKJ6Ka8v+ANoCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giRGY-0008DY-5j; Sat, 12 Jan 2019 21:56:30 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giRGJ-00080J-8w
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 21:56:16 +0000
Received: by mail-pl1-x642.google.com with SMTP id 101so8373420pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 12 Jan 2019 13:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V71ESkwkT2zYZktwYGjC1d8wlM//aQPO8lMe2StOgno=;
 b=bmjLQqeNnF1lrjG4rrullfqJ86jfF3jAG6l5jv1PTjXhjVdwYtusZ+D2drK8g4g3S5
 7/CjFQSQsU+2yFeE3p8QariGfumQLoNExjT/cl2o6cDXdmu1e27aHPkIKGK1dWy3/L1O
 BK+IGtHY3myAK1tRoya38Ae4gtniGI17zXrCxXHb9bmxvizbhpl+S/k7Z3ZE7Qb3QvlX
 evZHL/hReGFJHqQ1eYeh0tAiFuwBZ22iCoLaa7AMFQH6deHDIV8PHP4ex8EnIvJFGAvD
 cUBwkm7asr/Mkq0CoNEZs5Y4R22kfFUyzstMDQgIFO0De841EyTjSASzz+kL7EuFYjdW
 5sDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V71ESkwkT2zYZktwYGjC1d8wlM//aQPO8lMe2StOgno=;
 b=QKmNWJV6oHrup5sDw8ZwD2d7bBI426j1PYkEvpJ4DB77VVBryGQXmBHOjo8kEgA0Y4
 RqPm1cic56+OzJobfvmjwWlzCR5aUZe1v5ttJlsYamAoR0HGKDixKZG1lc6Tu+y+2hvt
 XY1Gjif2jGr5j/ywjE2UNXA7mLR5gurmHHJXi4NtdjutB4hFH59VpjUwRwvAgSEPKyU5
 PGDs6SVzD1gUjKfAUV0m2slXBwjX7nPuuaHcP4+RijooIB6jw/poR9KZUZbQdSLYJ6Nv
 ukU5R4/CtYNGrc0KA03KplCYelzwdUuHVIWx0ioqRSDo4QXPXkOjBF9nAYK2Km/XKe/A
 A0zQ==
X-Gm-Message-State: AJcUukd66d7lcVoP4XNOPV1ApUCgTH37TdknWHC6TiHlwZi5B1x6EBpO
 y0aqPbD3hbdhsGnSCaqpD3c=
X-Google-Smtp-Source: ALg8bN56q5jXFmKF/hlZCYaNJwg08akEg32lAmL5cpQmca0tmJlq5MmpzY4pbBvMZqfZOQfXzHb+Qw==
X-Received: by 2002:a17:902:1d4a:: with SMTP id
 u10mr19085641plu.122.1547330174206; 
 Sat, 12 Jan 2019 13:56:14 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i72sm122284327pfe.181.2019.01.12.13.56.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 12 Jan 2019 13:56:13 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v5 1/4] PCI: imx6: introduce drvdata
Date: Sat, 12 Jan 2019 13:55:58 -0800
Message-Id: <20190112215601.9535-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190112215601.9535-1-andrew.smirnov@gmail.com>
References: <20190112215601.9535-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_135615_310599_423FA4E3 
X-CRM114-Status: GOOD (  16.38  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Introduce driver data struct. This will simplify handling of device
specific differences.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
[andrew.smirnov@gmail.com reformatted drvdata, to simplify future diffs]
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 56 ++++++++++++++++++---------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 25a2b7683e55..efff3d5e9162 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -41,6 +41,10 @@ enum imx6_pcie_variants {
 	IMX7D,
 };
 
+struct imx6_pcie_drvdata {
+	enum imx6_pcie_variants variant;
+};
+
 struct imx6_pcie {
 	struct dw_pcie		*pci;
 	int			reset_gpio;
@@ -53,7 +57,6 @@ struct imx6_pcie {
 	struct reset_control	*pciephy_reset;
 	struct reset_control	*apps_reset;
 	struct reset_control	*turnoff_reset;
-	enum imx6_pcie_variants variant;
 	u32			tx_deemph_gen1;
 	u32			tx_deemph_gen2_3p5db;
 	u32			tx_deemph_gen2_6db;
@@ -66,6 +69,7 @@ struct imx6_pcie {
 	struct device		*pd_pcie;
 	/* power domain for pcie phy */
 	struct device		*pd_pcie_phy;
+	const struct imx6_pcie_drvdata *drvdata;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
@@ -340,7 +344,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct device *dev = imx6_pcie->pci->dev;
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		reset_control_assert(imx6_pcie->pciephy_reset);
 		reset_control_assert(imx6_pcie->apps_reset);
@@ -382,7 +386,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	struct device *dev = pci->dev;
 	int ret = 0;
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
 		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
 		if (ret) {
@@ -485,7 +489,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 					!imx6_pcie->gpio_active_high);
 	}
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
@@ -523,7 +527,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
@@ -645,7 +649,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6Q:
 	case IMX6SX:
 	case IMX6QP:
@@ -698,7 +702,7 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		tmp |= PORT_LOGIC_SPEED_CHANGE;
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 
-		if (imx6_pcie->variant != IMX7D) {
+		if (imx6_pcie->drvdata->variant != IMX7D) {
 			/*
 			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
 			 * from i.MX6 family when no link speed transition
@@ -801,7 +805,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
 	case IMX6QP:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -827,7 +831,7 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
 	}
 
 	/* Others poke directly at IOMUXC registers */
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
@@ -857,7 +861,7 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 	clk_disable_unprepare(imx6_pcie->pcie_phy);
 	clk_disable_unprepare(imx6_pcie->pcie_bus);
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
 		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
 		break;
@@ -873,8 +877,8 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 
 static inline bool imx6_pcie_supports_suspend(struct imx6_pcie *imx6_pcie)
 {
-	return (imx6_pcie->variant == IMX7D ||
-		imx6_pcie->variant == IMX6SX);
+	return (imx6_pcie->drvdata->variant == IMX7D ||
+		imx6_pcie->drvdata->variant == IMX6SX);
 }
 
 static int imx6_pcie_suspend_noirq(struct device *dev)
@@ -939,8 +943,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	pci->ops = &dw_pcie_ops;
 
 	imx6_pcie->pci = pci;
-	imx6_pcie->variant =
-		(enum imx6_pcie_variants)of_device_get_match_data(dev);
+	imx6_pcie->drvdata = of_device_get_match_data(dev);
 
 	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
@@ -984,7 +987,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(imx6_pcie->pcie);
 	}
 
-	switch (imx6_pcie->variant) {
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
 		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
 							   "pcie_inbound_axi");
@@ -1082,11 +1085,26 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 	imx6_pcie_assert_core_reset(imx6_pcie);
 }
 
+static const struct imx6_pcie_drvdata drvdata[] = {
+	[IMX6Q] = {
+		.variant = IMX6Q,
+	},
+	[IMX6SX] = {
+		.variant = IMX6SX,
+	},
+	[IMX6QP] = {
+		.variant = IMX6QP,
+	},
+	[IMX7D] = {
+		.variant = IMX7D,
+	},
+};
+
 static const struct of_device_id imx6_pcie_of_match[] = {
-	{ .compatible = "fsl,imx6q-pcie",  .data = (void *)IMX6Q,  },
-	{ .compatible = "fsl,imx6sx-pcie", .data = (void *)IMX6SX, },
-	{ .compatible = "fsl,imx6qp-pcie", .data = (void *)IMX6QP, },
-	{ .compatible = "fsl,imx7d-pcie",  .data = (void *)IMX7D,  },
+	{ .compatible = "fsl,imx6q-pcie",  .data = &drvdata[IMX6Q],  },
+	{ .compatible = "fsl,imx6sx-pcie", .data = &drvdata[IMX6SX], },
+	{ .compatible = "fsl,imx6qp-pcie", .data = &drvdata[IMX6QP], },
+	{ .compatible = "fsl,imx7d-pcie",  .data = &drvdata[IMX7D],  },
 	{},
 };
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
