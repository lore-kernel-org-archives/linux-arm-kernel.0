Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F31BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:23:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA7221841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IGtqw3Oy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA7221841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0kwVsVPNmE8sCb4/WxUU2Dx27O4Hh6i9UNRND3+0PrY=; b=IGtqw3OyPCCe9j
	expjr4qxPoJnQ54PIhKmLpg3zzUsFBkhZx6kLQGwt7/XTd72c6gdsAg1jByv8wxCyDGn2CSxB6XQs
	H/4v0t1g4S1k3iLFNJRF3vA/Rac4erPCVmXAWYkJAl+PY6Fc6dze68jaXQwPrkavtcweqtrUfBUyQ
	kxD80bTS4LRECS1WUAbDBRwHczSa5XRoDhXcd31y0GnJSMxpa38g2+hQY71xdijnxjUSxVtKEzfBD
	fLk0jYprr1pVLjoXbC1WAGuNSED1uLv49k6rgefVtHAfpVH3Jcp0FpSYB+bHqPrScQlsTImZuRvWO
	GQI9DNrofHzuidn7SKXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZWCK-0006Lm-EK; Wed, 19 Dec 2018 07:23:16 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZWCE-0006I0-2N; Wed, 19 Dec 2018 07:23:12 +0000
X-UUID: d42140e3420a438e91fd4889fb77d09b-20181219
X-UUID: d42140e3420a438e91fd4889fb77d09b-20181219
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by
 mailgw01.mediatek.com (envelope-from <biao.huang@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 721553360; Wed, 19 Dec 2018 15:22:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 19 Dec 2018 15:22:53 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 19 Dec 2018 15:22:53 +0800
From: Biao Huang <biao.huang@mediatek.com>
To: <davem@davemloft.net>, <robh+dt@kernel.org>
Subject: [v3, PATCH 2/2] net-next: stmmac: dwmac-mediatek: remove fine-tune
 property
Date: Wed, 19 Dec 2018 15:22:41 +0800
Message-ID: <1545204161-15742-3-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1545204161-15742-1-git-send-email-biao.huang@mediatek.com>
References: <1545204161-15742-1-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: B4648EA4B5EB803547499D3B3324E1FC534517B38244ABE2025337E9328BD3752000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_232310_363466_81B606CD 
X-CRM114-Status: GOOD (  12.82  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, nelson.chang@mediatek.com,
 andrew@lunn.ch, biao.huang@mediatek.com, netdev@vger.kernel.org,
 liguo.zhang@mediatek.com, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
 joabreu@synopsys.com, linux-mediatek@lists.infradead.org,
 honghui.zhang@mediatek.com, yt.shen@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

1. remove fine-tune property and related setting to simplify
the timing adjustment flow.
2. set timing value according to the value from device tree,
and will not care whether PHY insert internal delay.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |   71 +++++++-------------
 1 file changed, 24 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index e400cbd..bf25629 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -44,7 +44,6 @@ struct mac_delay_struct {
 	u32 rx_delay;
 	bool tx_inv;
 	bool rx_inv;
-	bool fine_tune;
 };
 
 struct mediatek_dwmac_plat_data {
@@ -105,16 +104,28 @@ static int mt2712_set_interface(struct mediatek_dwmac_plat_data *plat)
 	return 0;
 }
 
-static void mt2712_delay_ps2stage(struct mac_delay_struct *mac_delay)
+static void mt2712_delay_ps2stage(struct mediatek_dwmac_plat_data *plat)
 {
-	if (mac_delay->fine_tune) {
-		/* 170ps per stage for fine tune delay macro circuit*/
-		mac_delay->tx_delay /= 170;
-		mac_delay->rx_delay /= 170;
-	} else {
-		/* 550ps per stage for coarse tune delay macro circuit*/
+	struct mac_delay_struct *mac_delay = &plat->mac_delay;
+
+	switch (plat->phy_mode) {
+	case PHY_INTERFACE_MODE_MII:
+	case PHY_INTERFACE_MODE_RMII:
+		/* 550ps per stage for MII/RMII */
 		mac_delay->tx_delay /= 550;
 		mac_delay->rx_delay /= 550;
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		/* 170ps per stage for RGMII */
+		mac_delay->tx_delay /= 170;
+		mac_delay->rx_delay /= 170;
+		break;
+	default:
+		dev_err(plat->dev, "phy interface not supported\n");
+		break;
 	}
 }
 
@@ -123,7 +134,7 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
 	struct mac_delay_struct *mac_delay = &plat->mac_delay;
 	u32 delay_val = 0, fine_val = 0;
 
-	mt2712_delay_ps2stage(mac_delay);
+	mt2712_delay_ps2stage(plat);
 
 	switch (plat->phy_mode) {
 	case PHY_INTERFACE_MODE_MII:
@@ -167,13 +178,10 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
 			fine_val = ETH_RMII_DLY_TX_INV;
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
-		/* the PHY is not responsible for inserting any internal
-		 * delay by itself in PHY_INTERFACE_MODE_RGMII case,
-		 * so Ethernet MAC will insert delays for both transmit
-		 * and receive path here.
-		 */
-		if (mac_delay->fine_tune)
-			fine_val = ETH_FINE_DLY_GTXC | ETH_FINE_DLY_RXC;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		fine_val = ETH_FINE_DLY_GTXC | ETH_FINE_DLY_RXC;
 
 		delay_val |= FIELD_PREP(ETH_DLY_GTXC_ENABLE, !!mac_delay->tx_delay);
 		delay_val |= FIELD_PREP(ETH_DLY_GTXC_STAGES, mac_delay->tx_delay);
@@ -183,36 +191,6 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
 		delay_val |= FIELD_PREP(ETH_DLY_RXC_STAGES, mac_delay->rx_delay);
 		delay_val |= FIELD_PREP(ETH_DLY_RXC_INV, mac_delay->rx_inv);
 		break;
-	case PHY_INTERFACE_MODE_RGMII_TXID:
-		/* the PHY should insert an internal delay for the transmit
-		 * path in PHY_INTERFACE_MODE_RGMII_TXID case,
-		 * so Ethernet MAC will insert the delay for receive path here.
-		 */
-		if (mac_delay->fine_tune)
-			fine_val = ETH_FINE_DLY_RXC;
-
-		delay_val |= FIELD_PREP(ETH_DLY_RXC_ENABLE, !!mac_delay->rx_delay);
-		delay_val |= FIELD_PREP(ETH_DLY_RXC_STAGES, mac_delay->rx_delay);
-		delay_val |= FIELD_PREP(ETH_DLY_RXC_INV, mac_delay->rx_inv);
-		break;
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-		/* the PHY should insert an internal delay for the receive
-		 * path in PHY_INTERFACE_MODE_RGMII_RXID case,
-		 * so Ethernet MAC will insert the delay for transmit path here.
-		 */
-		if (mac_delay->fine_tune)
-			fine_val = ETH_FINE_DLY_GTXC;
-
-		delay_val |= FIELD_PREP(ETH_DLY_GTXC_ENABLE, !!mac_delay->tx_delay);
-		delay_val |= FIELD_PREP(ETH_DLY_GTXC_STAGES, mac_delay->tx_delay);
-		delay_val |= FIELD_PREP(ETH_DLY_GTXC_INV, mac_delay->tx_inv);
-		break;
-	case PHY_INTERFACE_MODE_RGMII_ID:
-		/* the PHY should insert internal delays for both transmit
-		 * and receive path in PHY_INTERFACE_MODE_RGMII_RXID case,
-		 * so Ethernet MAC will NOT insert any delay here.
-		 */
-		break;
 	default:
 		dev_err(plat->dev, "phy interface not supported\n");
 		return -EINVAL;
@@ -270,7 +248,6 @@ static int mediatek_dwmac_config_dt(struct mediatek_dwmac_plat_data *plat)
 
 	mac_delay->tx_inv = of_property_read_bool(plat->np, "mediatek,txc-inverse");
 	mac_delay->rx_inv = of_property_read_bool(plat->np, "mediatek,rxc-inverse");
-	mac_delay->fine_tune = of_property_read_bool(plat->np, "mediatek,fine-tune");
 	plat->rmii_rxc = of_property_read_bool(plat->np, "mediatek,rmii-rxc");
 
 	return 0;
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
