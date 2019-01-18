Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D952BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:26:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71EE20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nfMRz2VM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71EE20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vtqtzpSiskkraDE4mV4WtEctcwVmfSTt/BlfX0xoL6o=; b=nfMRz2VM5x3zRU
	TqdBr3ak5LrLlKqMjyoq5Y3U1HGEprYIp9cXnkyIjYvFyX5tlzIXa43uOmtlL979PE945Dr270yew
	s4rORhHKXxyEXzFZPac0KK6btyYZRleLNj/n+mKRzuzPuv9C1V7uv6WB07F6l6VX/rjtWlE+bT+1X
	y9Vw3KMgs3klyC+d7/99bC6Q3uwT9JEgsPkON/ToKcF7EtdAG+z5+2Y1Fg87wZaYKNW4vTPLNxt19
	tsdw5IeqqinYA0UCFwx3E90urw4CUFX/8a7V81D/4KD2q5Mn8/HHDM8mQei9nNLGIdXToM9hAFgdq
	lEB7zlyhDnmeDihVHpMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkW2L-0003Mq-79; Fri, 18 Jan 2019 15:26:25 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkW0O-0000Pc-Gs
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 15:24:43 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 3AEB720955; Fri, 18 Jan 2019 16:24:23 +0100 (CET)
Received: from mc-bl-xps13.lan
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 005BC20898;
 Fri, 18 Jan 2019 16:24:03 +0100 (CET)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next 4/7] net: phy: marvell10g: Add support for 2.5GBASET
 and 5GBASET
Date: Fri, 18 Jan 2019 16:23:49 +0100
Message-Id: <20190118152352.26417-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_072425_438294_EDBACC00 
X-CRM114-Status: GOOD (  15.08  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 mw@semihalf.com, Antoine Tenart <antoine.tenart@bootlin.com>,
 netdev@vger.kernel.org, gregory.clement@bootlin.com,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, nadavh@marvell.com,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
 Russell King <linux@armlinux.org.uk>, stefanc@marvell.com,
 linux-arm-kernel@lists.infradead.org, Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Marvell Alaska family of PHYs supports 2.5GBaseT and 5GBaseT modes,
as defined in the 802.3bz specification.

When the link partner requests a 2.5GBASET link, the PHY will
reconfigure it's MII interface to 2500BASEX.

At 5G, the PHY will reconfigure it's interface to 5GBASE-R, but this
mode isn't supported by any MAC for now.

This was tested with :
 - The 88X3310, which is on the MacchiatoBin
 - The 88E2010, an Alaska PHY that has no fiber interfaces, and is
   limited to 5G maximum speed.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/marvell10g.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index f2a6d6e7041a..f45ddf3bc138 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -255,6 +255,7 @@ static int mv3310_config_init(struct phy_device *phydev)
 
 	/* Check that the PHY interface type is compatible */
 	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
+	    phydev->interface != PHY_INTERFACE_MODE_2500BASEX &&
 	    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
 	    phydev->interface != PHY_INTERFACE_MODE_RXAUI &&
 	    phydev->interface != PHY_INTERFACE_MODE_10GKR)
@@ -264,8 +265,10 @@ static int mv3310_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	linkmode_and(phydev->advertising, phydev->advertising,
-		     phydev->supported);
+	/* Make sure we advertise all the supported modes, and not just the
+	 * default one specified in the driver's .features.
+	 */
+	linkmode_copy(phydev->advertising, phydev->supported);
 
 	return 0;
 }
@@ -314,8 +317,17 @@ static int mv3310_config_aneg(struct phy_device *phydev)
 	else
 		reg = 0;
 
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			      phydev->advertising))
+		reg |= MDIO_AN_10GBT_CTRL_ADV2_5G;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			      phydev->advertising))
+		reg |= MDIO_AN_10GBT_CTRL_ADV5G;
+
 	ret = mv3310_modify(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
-			    MDIO_AN_10GBT_CTRL_ADV10G, reg);
+			    MDIO_AN_10GBT_CTRL_ADV10G |
+			    MDIO_AN_10GBT_CTRL_ADV5G |
+			    MDIO_AN_10GBT_CTRL_ADV2_5G, reg);
 	if (ret < 0)
 		return ret;
 	if (ret > 0)
@@ -344,17 +356,20 @@ static int mv3310_aneg_done(struct phy_device *phydev)
 static void mv3310_update_interface(struct phy_device *phydev)
 {
 	if ((phydev->interface == PHY_INTERFACE_MODE_SGMII ||
+	     phydev->interface == PHY_INTERFACE_MODE_2500BASEX ||
 	     phydev->interface == PHY_INTERFACE_MODE_10GKR) && phydev->link) {
 		/* The PHY automatically switches its serdes interface (and
-		 * active PHYXS instance) between Cisco SGMII and 10GBase-KR
-		 * modes according to the speed.  Florian suggests setting
-		 * phydev->interface to communicate this to the MAC. Only do
-		 * this if we are already in either SGMII or 10GBase-KR mode.
+		 * active PHYXS instance) between Cisco SGMII, 10GBase-KR and
+		 * 2500BaseX modes according to the speed.  Florian suggests
+		 * setting phydev->interface to communicate this to the MAC.
+		 * Only do this if we are already in one of the above modes.
 		 */
 		if (phydev->speed == SPEED_10000)
 			phydev->interface = PHY_INTERFACE_MODE_10GKR;
+		else if (phydev->speed == SPEED_2500)
+			phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
 		else if (phydev->speed >= SPEED_10 &&
-			 phydev->speed < SPEED_10000)
+			 phydev->speed < SPEED_2500)
 			phydev->interface = PHY_INTERFACE_MODE_SGMII;
 	}
 }
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
