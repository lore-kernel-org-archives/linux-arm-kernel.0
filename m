Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD6DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:40:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0453820878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DTxuJDDL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zx0QwkvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0453820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FOEpPD667C9ozh18eCDgwGAlk7g4dtkz041z7bVWc5Y=; b=DTxuJDDLUt89Av
	LkTmeCgOf4r3ViFwmxBwUNt0Xy0w2Rdq9lOYJ6ZZfE4BfVAlyOOgXcodZMyoPvJ+vxQYiWIfDZ8zt
	tkc/hOMzPfV/0xF65LLVS84x0XgtYvHnQbVhwkv19QpEoqXLjsRIMRBoEIpES4DruRKGLONNhq230
	NmTaaPErZxmpgqmScVoCbW9qvf187GY5/aAj/C4d8K31lQ9dk5aS+QbfCA25qs+83R5X0GMRmUU5g
	hModYneE86FHdydbnzduaSLtiF6SZ3eDDRpgVjdxltsluW0CNFoPIkLcUQ/9n7GiQF1i0sH/jxxWM
	kB0AP0ZGirwx4fZxnqyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUoHD-0003K6-Af; Thu, 06 Dec 2018 07:40:51 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUoCg-0000X9-AR
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 07:36:18 +0000
Received: by mail-pl1-x644.google.com with SMTP id e5so11383451plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 23:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JsopjK7zH4q0Nw3Raq1i3v5Oy+hMRXGd6aNhJXLKDOo=;
 b=Zx0QwkvGqWvYleO5YxHykENoT/IEMpl+za83/8wJymnkSutF939Yo4l7ViwUNF0kwS
 IEJ0i7P860TG6PDGERo4b9fIUAKbDlE8CJ3DGRL9oKhmibtsqKxtrATGoJpXOvi+FJ4X
 vQQxOMkOsL8lJV8mFw/8AqmCYcH/Yn6tJgLTFFUG2n5CvfL846rczzdrzVOVjJK1vRgp
 P5F9ZR4V7lrd1meBqHXwS2vtVP5qdfrHaXWyKwGYVQUaneFze0nlY9DkAghiX3d8jPyG
 mMS0y61HGb3joqMEcgWjrcJjce7bhf/TIMh8g+fOOzvUmhCiOB4+CzHhWeNVQ7fNCGXS
 rn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JsopjK7zH4q0Nw3Raq1i3v5Oy+hMRXGd6aNhJXLKDOo=;
 b=YNeK8TEyB/nTi1qUc2plc2BI5I09pMgyf63CQv8oMTshU07hnAoelemoeZdhtxoPZc
 d/U6CPZupmZ5tRxbv5FipJHOBH+oMiuYEpZiQEIpWiaVXYnd2WrZ3fk9iXYEiqi0fblk
 phFwutF8Hg1dp5jjRWYIaBNFO/Q/q4gxow1+XaMHYh09/RrSbxWUlbSKDcp2zE5UBfXz
 hIKw70rPWEoQ6B39LnvsndRr5Gmom4Zuphbpvn0Kb71YysWjClmQb4ajmaPv1qNufh4F
 DIbwHe5XF3F5neTbglsuyoKCbTrsjNExpInd9A5/2U37fBoz2MOcl5JGw+jXTsv+wPLy
 w8tQ==
X-Gm-Message-State: AA+aEWZyPutlghNJMALB90fD22mrxXWiZWBqtqEPaM8QL1ke0kqOdirq
 1hUVKmt4Q+yU1JR9A1bg56E=
X-Google-Smtp-Source: AFSGD/W6GT9BTMXIBVJ1TrwhN0cnpSbhXZYZErwUM56TeiXs4JlLvPEtWZ1mBFL1f6Ml31IHTJQ8LQ==
X-Received: by 2002:a17:902:8541:: with SMTP id
 d1mr27811877plo.205.1544081759584; 
 Wed, 05 Dec 2018 23:35:59 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id v15sm33035894pfn.94.2018.12.05.23.35.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 23:35:58 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 3/3] PCI: imx: Add support for i.MX8MQ
Date: Wed,  5 Dec 2018 23:35:45 -0800
Message-Id: <20181206073545.10967-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206073545.10967-1-andrew.smirnov@gmail.com>
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_233610_640959_534796DC 
X-CRM114-Status: GOOD (  21.54  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
 devicetree@vger.kernel.org, linux-imx@nxp.com, bhelgaas@google.com,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add code needed to support i.MX8MQ variant.

Cc: bhelgaas@google.com
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 .../bindings/pci/fsl,imx6q-pcie.txt           |  6 +-
 drivers/pci/controller/dwc/Kconfig            |  2 +-
 drivers/pci/controller/dwc/pci-imx6.c         | 85 +++++++++++++++++--
 3 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index f37494d5a7be..40b46d11e7e7 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -9,6 +9,7 @@ Required properties:
 	- "fsl,imx6sx-pcie",
 	- "fsl,imx6qp-pcie"
 	- "fsl,imx7d-pcie"
+	- "fsl,imx8mq-pcie"
 - reg: base address and length of the PCIe controller
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
@@ -43,7 +44,7 @@ Additional required properties for imx6sx-pcie:
 	- "pcie_inbound_axi"
 - power-domains: Must be set to a phandle pointing to the PCIE_PHY power domain
 
-Additional required properties for imx7d-pcie:
+Additional required properties for imx7d-pcie and imx8mq-pcie:
 - power-domains: Must be set to a phandle pointing to PCIE_PHY power domain
 - resets: Must contain phandles to PCIe-related reset lines exposed by SRC
   IP block
@@ -52,6 +53,9 @@ Additional required properties for imx7d-pcie:
 	       - "apps"
 	       - "turnoff"
 
+Additional required properties for imx8mq-pcie:
+- fsl,controller-id: Logical ID of a given PCIE controller. PCIE1 is 0, PCIE2 is 1;
+
 Example:
 
 	pcie@01000000 {
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 91b0194240a5..2b139acccf32 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -90,7 +90,7 @@ config PCI_EXYNOS
 
 config PCI_IMX6
 	bool "Freescale i.MX6 PCIe controller"
-	depends on SOC_IMX6Q || (ARM && COMPILE_TEST)
+	depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3c3002861d25..326f71698ac2 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -8,6 +8,7 @@
  * Author: Sean Cross <xobs@kosagi.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
@@ -30,6 +31,11 @@
 
 #include "pcie-designware.h"
 
+#define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
+#define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN	BIT(10)
+#define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
+#define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
+
 #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx6_pcie_variants {
@@ -37,6 +43,7 @@ enum imx6_pcie_variants {
 	IMX6SX,
 	IMX6QP,
 	IMX7D,
+	IMX8MQ,
 };
 
 struct imx6_pcie {
@@ -48,6 +55,7 @@ struct imx6_pcie {
 	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
 	struct regmap		*iomuxc_gpr;
+	u32			controller_id;
 	struct reset_control	*pciephy_reset;
 	struct reset_control	*apps_reset;
 	struct reset_control	*turnoff_reset;
@@ -245,7 +253,8 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
 	u32 tmp;
 
-	if (imx6_pcie->variant == IMX7D)
+	if (imx6_pcie->variant == IMX7D ||
+	    imx6_pcie->variant == IMX8MQ)
 		return;
 
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
@@ -261,6 +270,7 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
 }
 
+#ifdef CONFIG_ARM
 /*  Added for PCI abort handling */
 static int imx6q_pcie_abort_handler(unsigned long addr,
 		unsigned int fsr, struct pt_regs *regs)
@@ -294,6 +304,7 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 
 	return 1;
 }
+#endif
 
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
@@ -301,6 +312,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 
 	switch (imx6_pcie->variant) {
 	case IMX7D:
+	case IMX8MQ: /* FALLTHROUGH */
 		reset_control_assert(imx6_pcie->pciephy_reset);
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
@@ -339,6 +351,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
+	unsigned int offset;
 	int ret = 0;
 
 	switch (imx6_pcie->variant) {
@@ -369,6 +382,29 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		break;
 	case IMX7D:
 		break;
+	case IMX8MQ:
+		switch (imx6_pcie->controller_id) {
+		case 0:
+			offset = IOMUXC_GPR14;
+			break;
+		case 1:
+			offset = IOMUXC_GPR16;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		/*
+		 * Set the over ride low and enabled
+		 * make sure that REF_CLK is turned on.
+		 */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
+				   0);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
+				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
+		break;
 	}
 
 	return ret;
@@ -445,6 +481,9 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	}
 
 	switch (imx6_pcie->variant) {
+	case IMX8MQ:
+		reset_control_deassert(imx6_pcie->pciephy_reset);
+		break;
 	case IMX7D:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
@@ -482,7 +521,34 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
+	unsigned int mask, val, offset;
+
+	mask = IMX6Q_GPR12_DEVICE_TYPE;
+	val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT);
+
 	switch (imx6_pcie->variant) {
+	case IMX8MQ:
+		switch (imx6_pcie->controller_id) {
+		case 0:
+			offset = IOMUXC_GPR14;
+			break;
+		case 1:
+			offset = IOMUXC_GPR16;
+			mask = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
+			val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+					  PCI_EXP_TYPE_ROOT_PORT);
+			break;
+		default:
+			return;
+		}
+		/*
+		 * TODO: Currently this code assumes external
+		 * oscillator is being used
+		 */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+				   IMX8MQ_GPR_PCIE_REF_USE_PAD,
+				   IMX8MQ_GPR_PCIE_REF_USE_PAD);
+		break;
 	case IMX7D:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
@@ -518,8 +584,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 		break;
 	}
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
 }
 
 static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
@@ -528,7 +593,8 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 	int mult, div;
 	u32 val;
 
-	if (imx6_pcie->variant == IMX7D)
+	if (imx6_pcie->variant == IMX7D ||
+	    imx6_pcie->variant == IMX8MQ)
 		return 0;
 
 	switch (phy_rate) {
@@ -616,6 +682,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 				   IMX6Q_GPR12_PCIE_CTL_2);
 		break;
 	case IMX7D:
+	case IMX8MQ:		/* FALLTHROUGH */
 		reset_control_deassert(imx6_pcie->apps_reset);
 		break;
 	}
@@ -870,6 +937,10 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	imx6_pcie->variant =
 		(enum imx6_pcie_variants)of_device_get_match_data(dev);
 
+	if (of_property_read_u32(node, "fsl,controller-id",
+				 &imx6_pcie->controller_id))
+		imx6_pcie->controller_id = 0;
+
 	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
 	if (IS_ERR(pci->dbi_base))
@@ -921,7 +992,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
 		}
 		break;
-	case IMX7D:
+	case IMX8MQ:
+	case IMX7D:		/* FALLTHROUGH */
 		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
 									    "pciephy");
 		if (IS_ERR(imx6_pcie->pciephy_reset)) {
@@ -1011,6 +1083,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6sx-pcie", .data = (void *)IMX6SX, },
 	{ .compatible = "fsl,imx6qp-pcie", .data = (void *)IMX6QP, },
 	{ .compatible = "fsl,imx7d-pcie",  .data = (void *)IMX7D,  },
+	{ .compatible = "fsl,imx8mq-pcie", .data = (void *)IMX8MQ, } ,
 	{},
 };
 
@@ -1027,6 +1100,7 @@ static struct platform_driver imx6_pcie_driver = {
 
 static int __init imx6_pcie_init(void)
 {
+#ifdef CONFIG_ARM
 	/*
 	 * Since probe() can be deferred we need to make sure that
 	 * hook_fault_code is not called after __init memory is freed
@@ -1036,6 +1110,7 @@ static int __init imx6_pcie_init(void)
 	 */
 	hook_fault_code(8, imx6q_pcie_abort_handler, SIGBUS, 0,
 			"external abort on non-linefetch");
+#endif
 
 	return platform_driver_register(&imx6_pcie_driver);
 }
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
