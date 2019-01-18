Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F82C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:26:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E212420657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VuzFFmWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E212420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3qGVVPmyYjKzrj1V9hmg51kNQ7T+oWRWoaemDOcIwec=; b=VuzFFmWiyTQisg
	RbZpxiQFFzoWD8/yn2G2p+b8pwaPgYURAP60Vz8uQ5LDwUjo7KAOvcQIcdffaKGhdX2IDvEUAhDT4
	2gKqpcf+wv/gPEhHp2YIczv54aM/vCBe8ZV0zoDuBrKGrm1lTa4YcPK3T+5a58JAKkERhzTECu0Rt
	OLLXBmWnNtb98+PQim+KMMBPvXV31kVvz3aABGe4HjPTPf6D9xA25TWKLkTGJqkmYVzHVeqtjW0BE
	1GR8CfeakUjsvd8SeiJs/FqMcaePS5RQXUjHBSAFC+zI85rEFf/mgFIjRP21t0c4/a3aP0PboXoND
	kKtIUcjfhItZhxoUGr/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkW26-00037V-PY; Fri, 18 Jan 2019 15:26:10 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkW0O-0000Pu-Sn
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 15:24:42 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 8EB8D209C0; Fri, 18 Jan 2019 16:24:23 +0100 (CET)
Received: from mc-bl-xps13.lan
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id EEA5C209EF;
 Fri, 18 Jan 2019 16:24:04 +0100 (CET)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next 7/7] net: phy: marvell10g: add support for the
 88x2110 PHY
Date: Fri, 18 Jan 2019 16:23:52 +0100
Message-Id: <20190118152352.26417-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_072425_470588_C295E80E 
X-CRM114-Status: GOOD (  13.89  )
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

This patch adds support for the 88x2110 PHY, which is similar to the
already supported 88x3310 PHY without the SFP interface.

It supports 10/100/1000BASET along with 2.5GBASET, 5GBASET and 10GBASET,
with the same interface modes that are used by the 3310.

This PHY don't have the same issue as the 88x3310 regarding 2.5/5G
abilities, and correctly follows the 802.3bz standard to list the
supported abilities.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Suggested-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/marvell10g.c | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 0a35bf0fac47..106491ecc016 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -290,6 +290,30 @@ static int mv3310_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int mv2110_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Check that the PHY interface type is compatible */
+	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
+	    phydev->interface != PHY_INTERFACE_MODE_2500BASEX &&
+	    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
+	    phydev->interface != PHY_INTERFACE_MODE_RXAUI &&
+	    phydev->interface != PHY_INTERFACE_MODE_10GKR)
+		return -ENODEV;
+
+	ret = genphy_c45_read_abilities(phydev);
+	if (ret)
+		return ret;
+
+	/* Make sure we advertise all the supported modes, and not just the
+	 * default one specified in the driver's .features.
+	 */
+	linkmode_copy(phydev->advertising, phydev->supported);
+
+	return 0;
+}
+
 static int mv3310_config_aneg(struct phy_device *phydev)
 {
 	bool changed = false;
@@ -504,12 +528,25 @@ static struct phy_driver mv3310_drivers[] = {
 		.aneg_done	= mv3310_aneg_done,
 		.read_status	= mv3310_read_status,
 	},
+	{
+		.phy_id		= 0x002b09b8,
+		.phy_id_mask	= MARVELL_PHY_ID_MASK,
+		.name		= "mv88x2110",
+		.features	= PHY_10GBIT_FEATURES,
+		.probe		= mv3310_probe,
+		.soft_reset	= gen10g_no_soft_reset,
+		.config_init	= mv2110_config_init,
+		.config_aneg	= mv3310_config_aneg,
+		.aneg_done	= mv3310_aneg_done,
+		.read_status	= mv3310_read_status,
+	},
 };
 
 module_phy_driver(mv3310_drivers);
 
 static struct mdio_device_id __maybe_unused mv3310_tbl[] = {
 	{ 0x002b09aa, MARVELL_PHY_ID_MASK },
+	{ 0x002b09b8, MARVELL_PHY_ID_MASK },
 	{ },
 };
 MODULE_DEVICE_TABLE(mdio, mv3310_tbl);
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
