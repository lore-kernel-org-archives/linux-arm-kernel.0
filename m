Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED20FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:11:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE7B206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UUCW3N54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE7B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Mw/GhBemX+v2Z0sIMKSKpNScXUKVEb2s7UdiMvvm32g=; b=UUC
	W3N54Ko74czVfWbAmlgO4I4WPvVC1FlZg6R1m1TYdIcjh8VQlvS7LtVk5ccS2yyzXMyr8xw1OKuar
	Lz5UEXkUgJ2lUwNpAcWswMSQqcp3YOOoiBmTvBnIM0TVjVaMm0331e38480xbxK+q7jTc60XoDCdr
	Rb+4T4p8AxZX72M961UG3nE62696LAc2jMy+qzoe7JBFzATnSEN61z481vEhRBsCk94AWLmrNYc47
	aVGpYDlxKrQNKPpmPsfPvwiltvz6effplYjYmPbHol4tESOGP2lAt1vITkOvUH0OeZWOTdE1BUZXl
	Tj1QrjqH11/GbaDtCPRp/4AiIZO414w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghXIv-0006AC-VX; Thu, 10 Jan 2019 10:11:14 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghXIg-0005vt-HU
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 10:11:01 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D4831A03BF;
 Thu, 10 Jan 2019 11:10:55 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 28CA71A0092;
 Thu, 10 Jan 2019 11:10:50 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 14232402C0;
 Thu, 10 Jan 2019 18:10:44 +0800 (SGT)
From: Peng Ma <peng.ma@nxp.com>
To: shawnguo@kernel.org,
	axboe@kernel.dk
Subject: [PATCH 1/2] ahci: qoriq: add lx2160 platforms support
Date: Thu, 10 Jan 2019 18:05:32 +0800
Message-Id: <20190110100533.33333-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_021058_862995_F5698A75 
X-CRM114-Status: UNSURE (   9.71  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Peng Ma <peng.ma@nxp.com>,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, linux-ide@vger.kernel.org,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Lx2160a is a new introduced soc which supports ATA3.0 and
Clean up some code

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
 drivers/ata/ahci_qoriq.c |   44 ++++++++++++--------------------------------
 1 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index ce59253..1994bf2 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -57,7 +57,7 @@ enum ahci_qoriq_type {
 	AHCI_LS2080A,
 	AHCI_LS1046A,
 	AHCI_LS1088A,
-	AHCI_LS2088A,
+	AHCI_LX2160A,
 };
 
 struct ahci_qoriq_priv {
@@ -73,7 +73,7 @@ struct ahci_qoriq_priv {
 	{ .compatible = "fsl,ls2080a-ahci", .data = (void *)AHCI_LS2080A},
 	{ .compatible = "fsl,ls1046a-ahci", .data = (void *)AHCI_LS1046A},
 	{ .compatible = "fsl,ls1088a-ahci", .data = (void *)AHCI_LS1088A},
-	{ .compatible = "fsl,ls2088a-ahci", .data = (void *)AHCI_LS2088A},
+	{ .compatible = "fsl,lx2160a-ahci", .data = (void *)AHCI_LX2160A},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_qoriq_of_match);
@@ -174,12 +174,10 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		writel(LS1021A_PORT_PHY4, reg_base + PORT_PHY4);
 		writel(LS1021A_PORT_PHY5, reg_base + PORT_PHY5);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-		if (qpriv->is_dmacoherent)
-			writel(AHCI_PORT_AXICC_CFG,
-					reg_base + LS1021A_AXICC_ADDR);
 		break;
 
 	case AHCI_LS1043A:
+	case AHCI_LS1046A:
 		if (!qpriv->ecc_addr)
 			return -EINVAL;
 		writel(readl(qpriv->ecc_addr) | ECC_DIS_ARMV8_CH2,
@@ -188,8 +186,6 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
 		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-		if (qpriv->is_dmacoherent)
-			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
 		break;
 
 	case AHCI_LS2080A:
@@ -197,24 +193,10 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
 		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-		if (qpriv->is_dmacoherent)
-			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
-		break;
-
-	case AHCI_LS1046A:
-		if (!qpriv->ecc_addr)
-			return -EINVAL;
-		writel(readl(qpriv->ecc_addr) | ECC_DIS_ARMV8_CH2,
-				qpriv->ecc_addr);
-		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
-		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
-		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
-		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-		if (qpriv->is_dmacoherent)
-			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
 		break;
 
 	case AHCI_LS1088A:
+	case AHCI_LX2160A:
 		if (!qpriv->ecc_addr)
 			return -EINVAL;
 		writel(readl(qpriv->ecc_addr) | ECC_DIS_LS1088A,
@@ -223,18 +205,16 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
 		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-		if (qpriv->is_dmacoherent)
-			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
 		break;
+	}
 
-	case AHCI_LS2088A:
-		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
-		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
-		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
-		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-		if (qpriv->is_dmacoherent)
-			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
-		break;
+	if (qpriv->is_dmacoherent) {
+		if (qpriv->type == AHCI_LS1021A)
+			writel(AHCI_PORT_AXICC_CFG,
+			       reg_base + LS1021A_AXICC_ADDR);
+		else
+			writel(AHCI_PORT_AXICC_CFG,
+			       reg_base + PORT_AXICC);
 	}
 
 	return 0;
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
