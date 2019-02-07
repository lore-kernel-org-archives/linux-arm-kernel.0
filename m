Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD43C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:52:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DDCF20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d6n2OPkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDCF20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a6MJTzUzLdLG4dm5PjFMjePsokZviwdyMekCl2AjzJw=; b=d6n2OPkZFWWGpU
	nWR8K0RpAbMxNrR8ZBZ6HJntAc77dCllZ4qi4fXKzhfsZPRHMcTbrYdrC9AE8h8RDSf8n1QauFgAV
	33Cd/kJm2NPVD660+I7GVJdvSp5yh6P5BRoC/mp0nftYotU/l1c0FHG2Cpu2OcVdSLaTnSw/8+bMS
	Kt8Wb9GWSFlo+HkkcvFirvJMuq7AF4oFzOoSd1lWUIx4Xi5oAViCOOhdQyEDc3D1G7uVWQlVeyEc4
	V5dN/ONF/YVg1ul8HDrEE9ikjlHmo/1NhCJJiAArxbGzYHisIe9oQrHeZ3muaxddkRQvMwFc9IZ/m
	8WMOH/d3wwW9qjkl86Yw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grgM6-0000Gk-K7; Thu, 07 Feb 2019 09:52:26 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grgK3-00063U-9G
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 09:50:27 +0000
Received: from mc-bl-xps13.lan
 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
 (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 197DD10001F;
 Thu,  7 Feb 2019 09:50:14 +0000 (UTC)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next v2 07/10] net: phy: marvell10g: Add support for
 2.5GBASET
Date: Thu,  7 Feb 2019 10:49:36 +0100
Message-Id: <20190207094939.27369-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_015020_090679_256184C0 
X-CRM114-Status: GOOD (  16.34  )
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
V1 -> V2: Use a #define for the 88X3310 PHY ID, since it's reused in
	  various places in the code. Rebased on Heiner Kallweit's patch
	  introducing the phy_modify_mmd accessor.

 drivers/net/phy/marvell10g.c | 30 ++++++++++++++++++++++--------
 include/linux/marvell_phy.h  |  1 +
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 07df87b81369..581b4b6e31e9 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -238,6 +238,7 @@ static int mv3310_config_init(struct phy_device *phydev)
 
 	/* Check that the PHY interface type is compatible */
 	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
+	    phydev->interface != PHY_INTERFACE_MODE_2500BASEX &&
 	    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
 	    phydev->interface != PHY_INTERFACE_MODE_RXAUI &&
 	    phydev->interface != PHY_INTERFACE_MODE_10GKR)
@@ -307,8 +308,18 @@ static int mv3310_config_aneg(struct phy_device *phydev)
 	else
 		reg = 0;
 
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			      phydev->advertising))
+		reg |= MDIO_AN_10GBT_CTRL_ADV2_5G;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			      phydev->advertising))
+		reg |= MDIO_AN_10GBT_CTRL_ADV5G;
+
 	ret = phy_modify_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
-			     MDIO_AN_10GBT_CTRL_ADV10G, reg);
+			     MDIO_AN_10GBT_CTRL_ADV10G |
+			     MDIO_AN_10GBT_CTRL_ADV5G |
+			     MDIO_AN_10GBT_CTRL_ADV2_5G, reg);
+
 	if (ret < 0)
 		return ret;
 	if (ret > 0)
@@ -337,17 +348,20 @@ static int mv3310_aneg_done(struct phy_device *phydev)
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
@@ -450,7 +464,7 @@ static int mv3310_read_status(struct phy_device *phydev)
 
 static struct phy_driver mv3310_drivers[] = {
 	{
-		.phy_id		= 0x002b09aa,
+		.phy_id		= MARVELL_PHY_ID_88X3310,
 		.phy_id_mask	= MARVELL_PHY_ID_MASK,
 		.name		= "mv88x3310",
 		.features	= PHY_10GBIT_FEATURES,
@@ -468,7 +482,7 @@ static struct phy_driver mv3310_drivers[] = {
 module_phy_driver(mv3310_drivers);
 
 static struct mdio_device_id __maybe_unused mv3310_tbl[] = {
-	{ 0x002b09aa, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88X3310, MARVELL_PHY_ID_MASK },
 	{ },
 };
 MODULE_DEVICE_TABLE(mdio, mv3310_tbl);
diff --git a/include/linux/marvell_phy.h b/include/linux/marvell_phy.h
index 1eb6f244588d..5851d68d828a 100644
--- a/include/linux/marvell_phy.h
+++ b/include/linux/marvell_phy.h
@@ -20,6 +20,7 @@
 #define MARVELL_PHY_ID_88E1540		0x01410eb0
 #define MARVELL_PHY_ID_88E1545		0x01410ea0
 #define MARVELL_PHY_ID_88E3016		0x01410e60
+#define MARVELL_PHY_ID_88X3310		0x002b09aa
 
 /* The MV88e6390 Ethernet switch contains embedded PHYs. These PHYs do
  * not have a model ID. So the switch driver traps reads to the ID2
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
