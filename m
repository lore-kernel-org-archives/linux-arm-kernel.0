Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE9EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:36:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF8C20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nP8IEqAx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VdLCmPG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF8C20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:MIME-Version:Subject:To
	:From:References:In-Reply-To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HOwTRu0NyHp+ahiASFkDJ004Vg9SBSUw+4eqOagOoz8=; b=nP8IEqAxaldSqA
	nfudDG9PgwM53orxTIbEx+Jxvkhe1l5yw7uaVV9hMGrNp6q9/u3OnELHAp1uGUeXI1kFH/m6k6Pko
	5SC5iKgIjJzJjW1klwntkNP7daiXuBO70NAlUdSvSSQXmTSeAVJf8XCZCun/7JETbwCIqErQoTiqU
	V3UZrwBfAOn9MWZCL3hMA+771G0RLEyggf7JDsN9pn3EnPYKDlPyv2spsu1dlT67LjN011y8e8tza
	1IFpIUH4kN7qqPgi/VhVXqPTC6t39MOCZ6dQFvdWVfTNalPKbOR9+Gk0MCBiUDsceop7djgs/2BnC
	dgD6hoodrfyo044udzQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grLVa-0001NS-Fp; Wed, 06 Feb 2019 11:36:50 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grLUe-0000GO-D0
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 11:36:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
 In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+lewa3YwcAe8FhDKNq4jyqveSVnz4nIkRkT0i7c/dNM=; b=VdLCmPG36gdGXmE0m8gdGqJAtl
 VPPmDuAte5ouwJjLF84IqZOMw+bnPNQz7uSX3V+6B+UA7nHue8WRzMuD1o3cFO2bfMppsny9dMzub
 5TwTlKBFbcvIDljnr4Gvs77j+qxfxuCtZzCSB3RJBQH4k+8HCpSDX/Y4dq5UqVX5ZBnI=;
Received: from e0022681537dd.dyn.armlinux.org.uk
 ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39494 helo=rmk-PC.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <rmk@armlinux.org.uk>)
 id 1grLTz-0001CI-E0; Wed, 06 Feb 2019 11:35:11 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim
 4.82_1-5b7a7c0-XX) (envelope-from <rmk@armlinux.org.uk>)
 id 1grLTv-00061v-Tw; Wed, 06 Feb 2019 11:35:08 +0000
In-Reply-To: <20190206113409.ko7lwuv5kb7l7rjo@shell.armlinux.org.uk>
References: <20190206113409.ko7lwuv5kb7l7rjo@shell.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Kishon Vijay Abraham I <kishon@ti.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH net-next 5/6] net: marvell: neta: add comphy support
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1grLTv-00061v-Tw@rmk-PC.armlinux.org.uk>
Date: Wed, 06 Feb 2019 11:35:07 +0000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_033553_383943_52B081E4 
X-CRM114-Status: GOOD (  16.86  )
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
Cc: devicetree@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support for the common phy binding, so that we can reconfigure the
comphy according to the desired ethernet speed.  This will allow us to
support 1000base-X and 2500base-X SFPs dynamically on SolidRun Clearfog.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/marvell/mvneta.c | 57 ++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 61b23497f836..86bdb0eb463a 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -27,6 +27,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
+#include <linux/phy/phy.h>
 #include <linux/phy.h>
 #include <linux/phylink.h>
 #include <linux/platform_device.h>
@@ -436,6 +437,7 @@ struct mvneta_port {
 	struct device_node *dn;
 	unsigned int tx_csum_limit;
 	struct phylink *phylink;
+	struct phy *comphy;
 
 	struct mvneta_bm *bm_priv;
 	struct mvneta_bm_pool *pool_long;
@@ -3151,6 +3153,8 @@ static void mvneta_start_dev(struct mvneta_port *pp)
 {
 	int cpu;
 
+	WARN_ON(phy_power_on(pp->comphy));
+
 	mvneta_max_rx_size_set(pp, pp->pkt_size);
 	mvneta_txq_max_tx_size_set(pp, pp->pkt_size);
 
@@ -3213,6 +3217,8 @@ static void mvneta_stop_dev(struct mvneta_port *pp)
 
 	mvneta_tx_reset(pp);
 	mvneta_rx_reset(pp);
+
+	WARN_ON(phy_power_off(pp->comphy));
 }
 
 static void mvneta_percpu_enable(void *arg)
@@ -3338,6 +3344,7 @@ static int mvneta_set_mac_addr(struct net_device *dev, void *addr)
 static void mvneta_validate(struct net_device *ndev, unsigned long *supported,
 			    struct phylink_link_state *state)
 {
+	struct mvneta_port *pp = netdev_priv(ndev);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
 
 	/* We only support QSGMII, SGMII, 802.3z and RGMII modes */
@@ -3358,8 +3365,13 @@ static void mvneta_validate(struct net_device *ndev, unsigned long *supported,
 	phylink_set(mask, Pause);
 
 	/* Half-duplex at speeds higher than 100Mbit is unsupported */
-	phylink_set(mask, 1000baseT_Full);
-	phylink_set(mask, 1000baseX_Full);
+	if (pp->comphy || state->interface != PHY_INTERFACE_MODE_2500BASEX) {
+		phylink_set(mask, 1000baseT_Full);
+		phylink_set(mask, 1000baseX_Full);
+	}
+	if (pp->comphy || state->interface == PHY_INTERFACE_MODE_2500BASEX) {
+		phylink_set(mask, 2500baseX_Full);
+	}
 
 	if (!phy_interface_mode_is_8023z(state->interface)) {
 		/* 10M and 100M are only supported in non-802.3z mode */
@@ -3373,6 +3385,11 @@ static void mvneta_validate(struct net_device *ndev, unsigned long *supported,
 		   __ETHTOOL_LINK_MODE_MASK_NBITS);
 	bitmap_and(state->advertising, state->advertising, mask,
 		   __ETHTOOL_LINK_MODE_MASK_NBITS);
+
+	/* We can only operate at 2500BaseX or 1000BaseX.  If requested
+	 * to advertise both, only report advertising at 2500BaseX.
+	 */
+	phylink_helper_basex_speed(state);
 }
 
 static int mvneta_mac_link_state(struct net_device *ndev,
@@ -3384,7 +3401,9 @@ static int mvneta_mac_link_state(struct net_device *ndev,
 	gmac_stat = mvreg_read(pp, MVNETA_GMAC_STATUS);
 
 	if (gmac_stat & MVNETA_GMAC_SPEED_1000)
-		state->speed = SPEED_1000;
+		state->speed =
+			state->interface == PHY_INTERFACE_MODE_2500BASEX ?
+			SPEED_2500 : SPEED_1000;
 	else if (gmac_stat & MVNETA_GMAC_SPEED_100)
 		state->speed = SPEED_100;
 	else
@@ -3499,12 +3518,32 @@ static void mvneta_mac_config(struct net_device *ndev, unsigned int mode,
 			    MVNETA_GMAC_FORCE_LINK_DOWN);
 	}
 
+
 	/* When at 2.5G, the link partner can send frames with shortened
 	 * preambles.
 	 */
 	if (state->speed == SPEED_2500)
 		new_ctrl4 |= MVNETA_GMAC4_SHORT_PREAMBLE_ENABLE;
 
+	if (pp->comphy) {
+		enum phy_mode mode = PHY_MODE_INVALID;
+
+		switch (state->interface) {
+		case PHY_INTERFACE_MODE_SGMII:
+		case PHY_INTERFACE_MODE_1000BASEX:
+			mode = PHY_MODE_SGMII;
+			break;
+		case PHY_INTERFACE_MODE_2500BASEX:
+			mode = PHY_MODE_2500SGMII;
+			break;
+		default:
+			break;
+		}
+
+		if (mode != PHY_MODE_INVALID)
+			WARN_ON(phy_set_mode(pp->comphy, mode));
+	}
+
 	if (new_ctrl0 != gmac_ctrl0)
 		mvreg_write(pp, MVNETA_GMAC_CTRL_0, new_ctrl0);
 	if (new_ctrl2 != gmac_ctrl2)
@@ -4405,7 +4444,7 @@ static int mvneta_port_power_up(struct mvneta_port *pp, int phy_mode)
 	if (phy_mode == PHY_INTERFACE_MODE_QSGMII)
 		mvreg_write(pp, MVNETA_SERDES_CFG, MVNETA_QSGMII_SERDES_PROTO);
 	else if (phy_mode == PHY_INTERFACE_MODE_SGMII ||
-		 phy_mode == PHY_INTERFACE_MODE_1000BASEX)
+		 phy_interface_mode_is_8023z(phy_mode))
 		mvreg_write(pp, MVNETA_SERDES_CFG, MVNETA_SGMII_SERDES_PROTO);
 	else if (!phy_interface_mode_is_rgmii(phy_mode))
 		return -EINVAL;
@@ -4422,6 +4461,7 @@ static int mvneta_probe(struct platform_device *pdev)
 	struct mvneta_port *pp;
 	struct net_device *dev;
 	struct phylink *phylink;
+	struct phy *comphy;
 	const char *dt_mac_addr;
 	char hw_mac_addr[ETH_ALEN];
 	const char *mac_from;
@@ -4447,6 +4487,14 @@ static int mvneta_probe(struct platform_device *pdev)
 		goto err_free_irq;
 	}
 
+	comphy = devm_of_phy_get(&pdev->dev, dn, NULL);
+	if (comphy == ERR_PTR(-EPROBE_DEFER)) {
+		err = -EPROBE_DEFER;
+		goto err_free_irq;
+	} else if (IS_ERR(comphy)) {
+		comphy = NULL;
+	}
+
 	phylink = phylink_create(dev, pdev->dev.fwnode, phy_mode,
 				 &mvneta_phylink_ops);
 	if (IS_ERR(phylink)) {
@@ -4463,6 +4511,7 @@ static int mvneta_probe(struct platform_device *pdev)
 	pp = netdev_priv(dev);
 	spin_lock_init(&pp->lock);
 	pp->phylink = phylink;
+	pp->comphy = comphy;
 	pp->phy_interface = phy_mode;
 	pp->dn = dn;
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
