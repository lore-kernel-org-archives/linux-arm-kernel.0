Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3CAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:43:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C9B2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eMraERqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C9B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F2I5ZCvK7TWhfQiisENyOKpYDctEZ8OnNUe87GRwgzk=; b=eMraERqqZPEP5t
	fvLE+LW9USV1BeHja/FlNoSvCKqfbl4s+3FK0R+WR1iDNIjValdu5cvNd8IFH1OFXTAmd6VjQ+O/v
	tKx8rETE+uIrNHOaHpZ56Id9/J0jKaZYQG48ZBVjbm6Kb+tQSzBoxdYkseARmjsg9hzZcFWCR6wdZ
	jbm2+bEFbsqgLrXSMXiRB6DMUEkqYCwM3OwcXZ0AfnX9oIBY5VKlGOuU6xhwLsu/KS6OQjtxA+6HO
	KJlzHrbdFGi+AeLpBcrSelNiK6rmhrrijUtbq1YpCeQujoBiBv1Klu/5C6kGCmJ56wv5bTg8RIn2j
	eCqWR+DWWlEfOEDt6DsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ5Lm-00038i-NY; Tue, 18 Dec 2018 02:43:14 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ5LR-0002dj-Nh; Tue, 18 Dec 2018 02:42:57 +0000
X-UUID: 2a8cf2235d7944129de7f51e1be54daf-20181218
X-UUID: 2a8cf2235d7944129de7f51e1be54daf-20181218
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <biao.huang@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 834688985; Tue, 18 Dec 2018 10:42:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 18 Dec 2018 10:42:28 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 10:42:27 +0800
From: Biao Huang <biao.huang@mediatek.com>
To: <davem@davemloft.net>, <robh+dt@kernel.org>
Subject: [PATCH 2/2] net-next: stmmac: dwmac-mediatek: remove fine-tune
 property
Date: Tue, 18 Dec 2018 10:42:17 +0800
Message-ID: <1545100937-16093-3-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1545100937-16093-1-git-send-email-biao.huang@mediatek.com>
References: <1545100937-16093-1-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_184254_670563_62057B53 
X-CRM114-Status: GOOD (  12.08  )
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
index e400cbd..801c797 100644
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
+		/* 550ps per stage for mii/rmii*/
 		mac_delay->tx_delay /= 550;
 		mac_delay->rx_delay /= 550;
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		/* 170ps per stage for mii/rmii*/
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
