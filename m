Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BD1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:02:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A74E208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sM5FfAMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A74E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=blM9iY17SD3WYinUJdpGmnXp2IigIpSy2TznVzXqD5c=; b=sM5FfAMMb2I1imcPnrHtwCIgBs
	6BWOi35dOIwDOz6mH5aeFbKqew/V2s14U+ibVTlCxxEnsVckTRiKWBfPwsuqnm8eio0guCHNmlBlN
	upDeWKtmV0qt6L3024n6glwccXaTD3vnqwQbYZesTDMlgQ3oAMblnRvLv702uljxpj0Vz4daq38pv
	gVbpbwld9DKltjPK30iKV2W26B8mmXtgBgBGi4UwtKaqiHQWW26/br1bE7OvN6xZov+PXZe85xNeK
	GeWqJhWCTlgPXPZyk/0L1UUlONe2cnOH9UEpXMjONW2sjy9jhAQg2ed2zFZtiC9PiLcJ/Unrm3T0G
	FNyCxStA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwNlv-00022H-9e; Wed, 20 Feb 2019 09:02:31 +0000
Received: from inva021.nxp.com ([92.121.34.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwNlh-0001oe-7l
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 09:02:19 +0000
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1EE592002E3;
 Wed, 20 Feb 2019 10:02:14 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 813D720017D;
 Wed, 20 Feb 2019 10:02:08 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A1145402C9;
 Wed, 20 Feb 2019 17:02:01 +0800 (SGT)
From: Peng Ma <peng.ma@nxp.com>
To: axboe@kernel.dk, robh+dt@kernel.org, mark.rutland@arm.com,
 shawnguo@kernel.org, leoyang.li@nxp.com, andy.tang@nxp.com
Subject: [v6 3/3] ahci: qoriq: add lx2160 platforms support
Date: Wed, 20 Feb 2019 08:56:07 +0000
Message-Id: <20190220085607.31582-3-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190220085607.31582-1-peng.ma@nxp.com>
References: <20190220085607.31582-1-peng.ma@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_010217_550769_21C11E26 
X-CRM114-Status: GOOD (  11.90  )
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
Cc: devicetree@vger.kernel.org, Peng Ma <peng.ma@nxp.com>,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 yousaf.kaukab@suse.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Lx2160a is a new introduced soc which supports ATA3.0

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
changed for V6:
	- Add ecc_initialized to ensure set sata bit once of
	ECC error register
	- Recovery AHCI_LS2088A platform

 drivers/ata/ahci_qoriq.c |   52 +++++++++++++++++++++++++++++++---------------
 1 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index ce59253..08dbb86 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -58,6 +58,7 @@ enum ahci_qoriq_type {
 	AHCI_LS1046A,
 	AHCI_LS1088A,
 	AHCI_LS2088A,
+	AHCI_LX2160A,
 };
 
 struct ahci_qoriq_priv {
@@ -67,6 +68,8 @@ struct ahci_qoriq_priv {
 	bool is_dmacoherent;
 };
 
+static bool ecc_initialized;
+
 static const struct of_device_id ahci_qoriq_of_match[] = {
 	{ .compatible = "fsl,ls1021a-ahci", .data = (void *)AHCI_LS1021A},
 	{ .compatible = "fsl,ls1043a-ahci", .data = (void *)AHCI_LS1043A},
@@ -74,6 +77,7 @@ struct ahci_qoriq_priv {
 	{ .compatible = "fsl,ls1046a-ahci", .data = (void *)AHCI_LS1046A},
 	{ .compatible = "fsl,ls1088a-ahci", .data = (void *)AHCI_LS1088A},
 	{ .compatible = "fsl,ls2088a-ahci", .data = (void *)AHCI_LS2088A},
+	{ .compatible = "fsl,lx2160a-ahci", .data = (void *)AHCI_LX2160A},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_qoriq_of_match);
@@ -165,9 +169,10 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 
 	switch (qpriv->type) {
 	case AHCI_LS1021A:
-		if (!qpriv->ecc_addr)
+		if (!(qpriv->ecc_addr || ecc_initialized))
 			return -EINVAL;
-		writel(SATA_ECC_DISABLE, qpriv->ecc_addr);
+		else if (qpriv->ecc_addr && !ecc_initialized)
+			writel(SATA_ECC_DISABLE, qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(LS1021A_PORT_PHY2, reg_base + PORT_PHY2);
 		writel(LS1021A_PORT_PHY3, reg_base + PORT_PHY3);
@@ -180,10 +185,12 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		break;
 
 	case AHCI_LS1043A:
-		if (!qpriv->ecc_addr)
+		if (!(qpriv->ecc_addr || ecc_initialized))
 			return -EINVAL;
-		writel(readl(qpriv->ecc_addr) | ECC_DIS_ARMV8_CH2,
-				qpriv->ecc_addr);
+		else if (qpriv->ecc_addr && !ecc_initialized)
+			writel(readl(qpriv->ecc_addr) |
+			       ECC_DIS_ARMV8_CH2,
+			       qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
 		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
@@ -202,10 +209,12 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		break;
 
 	case AHCI_LS1046A:
-		if (!qpriv->ecc_addr)
+		if (!(qpriv->ecc_addr || ecc_initialized))
 			return -EINVAL;
-		writel(readl(qpriv->ecc_addr) | ECC_DIS_ARMV8_CH2,
-				qpriv->ecc_addr);
+		else if (qpriv->ecc_addr && !ecc_initialized)
+			writel(readl(qpriv->ecc_addr) |
+			       ECC_DIS_ARMV8_CH2,
+			       qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
 		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
@@ -215,10 +224,13 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		break;
 
 	case AHCI_LS1088A:
-		if (!qpriv->ecc_addr)
+	case AHCI_LX2160A:
+		if (!(qpriv->ecc_addr || ecc_initialized))
 			return -EINVAL;
-		writel(readl(qpriv->ecc_addr) | ECC_DIS_LS1088A,
-		       qpriv->ecc_addr);
+		else if (qpriv->ecc_addr && !ecc_initialized)
+			writel(readl(qpriv->ecc_addr) |
+			       ECC_DIS_LS1088A,
+			       qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
 		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
@@ -237,6 +249,7 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		break;
 	}
 
+	ecc_initialized = true;
 	return 0;
 }
 
@@ -264,13 +277,18 @@ static int ahci_qoriq_probe(struct platform_device *pdev)
 
 	qoriq_priv->type = (enum ahci_qoriq_type)of_id->data;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-			"sata-ecc");
-	if (res) {
-		qoriq_priv->ecc_addr = devm_ioremap_resource(dev, res);
-		if (IS_ERR(qoriq_priv->ecc_addr))
-			return PTR_ERR(qoriq_priv->ecc_addr);
+	if (unlikely(!ecc_initialized)) {
+		res = platform_get_resource_byname(pdev,
+						   IORESOURCE_MEM,
+						   "sata-ecc");
+		if (res) {
+			qoriq_priv->ecc_addr =
+				devm_ioremap_resource(dev, res);
+			if (IS_ERR(qoriq_priv->ecc_addr))
+				return PTR_ERR(qoriq_priv->ecc_addr);
+		}
 	}
+
 	qoriq_priv->is_dmacoherent = of_dma_is_coherent(np);
 
 	rc = ahci_platform_enable_resources(hpriv);
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
