Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2021C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:52:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40E42148D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y3ccNMEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40E42148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YoX3C0CokgV2GkGl0ROIclHWIOkvKJ6eoM1PiHdolvQ=; b=Y3ccNMEQOGbBD/
	LvfWGnka+YR9z9xkaDhJckCJCkFJfAEWFe40LTsnoqtButE5/sjEBOkIQ6DJo9C8yUcG4UoX6hw+J
	taGdsW+w4caj+0x7Xwiri/kV83HqLWmf2/IwPEfyfIt3M8ZBZ5ENC9APeBxkotYuyDqWGdcyAIbuP
	4s/D17mNml0dnGSFMiEqKxV2lPGX9Ir5WaN0/1ixJTcl0wdLm1kg1twUtsQyh9xx20FSLT2PvlfKN
	t3/ygRS7VhzJlheNTv6cWphATJ1JNxL1vxzBsOqKe97VCcn84ZiZLbWdN9KWafW//ZIij1uaIFl2Z
	wVln5Omut+/wyQKohS6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwl25-0002KL-W4; Thu, 21 Feb 2019 09:52:46 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwl1B-0001D6-Mx
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 09:51:57 +0000
X-Originating-IP: 90.88.23.190
Received: from mc-bl-xps13.lan
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id A5707C0017;
 Thu, 21 Feb 2019 09:51:45 +0000 (UTC)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next 5/7] net: phy: marvell10g: Force reading of 2.5/5G
Date: Thu, 21 Feb 2019 10:51:26 +0100
Message-Id: <20190221095128.28188-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190221095128.28188-1-maxime.chevallier@bootlin.com>
References: <20190221095128.28188-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_015151_049747_283FE61D 
X-CRM114-Status: GOOD (  14.68  )
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

As per 802.3bz, if bit 14 of (1.11) "PMA Extended Abilities" indicates
whether or not we should read register (1.21) "2.52/5G PMA Extended
Abilities", which contains information on the support of 2.5GBASET and
5GBASET.

After testing on several variants of PHYS of this family, it appears
that bit 14 in (1.11) isn't always set when it should be.

PHYs 88X3310 (on MacchiatoBin) and 88E2010 do support 2.5G and 5GBASET,
but don't have 1.11.14 set. Their register 1.21 is filled with the
correct values, indicating 2.5G and 5G support.

PHYs 88E2110 do have their 1.11.14 bit set, as it should.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/marvell10g.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 9323bcf15dbd..c48669d50653 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -27,6 +27,9 @@
 #include <linux/marvell_phy.h>
 #include <linux/phy.h>
 
+#define MV_PHY_ALASKA_NBT_QUIRK_MASK	0xfffffffe
+#define MV_PHY_ALASKA_NBT_QUIRK_REV	(MARVELL_PHY_ID_88X3310 | 0xa)
+
 enum {
 	MV_PCS_BASE_T		= 0x0000,
 	MV_PCS_BASE_R		= 0x1000,
@@ -231,6 +234,23 @@ static int mv3310_resume(struct phy_device *phydev)
 	return mv3310_hwmon_config(phydev, true);
 }
 
+/* Some PHYs in the Alaska family such as the 88X3310 and the 88E2010
+ * don't set bit 14 in PMA Extended Abilities (1.11), although they do
+ * support 2.5GBASET and 5GBASET. For these models, we can still read their
+ * 2.5G/5G extended abilities register (1.21). We detect these models based on
+ * the PMA device identifier, with a mask matching models known to have this
+ * issue
+ */
+static bool mv3310_has_pma_ngbaset_quirk(struct phy_device *phydev)
+{
+	if (!(phydev->c45_ids.devices_in_package & MDIO_DEVS_PMAPMD))
+		return false;
+
+	/* Only some revisions of the 88X3310 family PMA seem to be impacted */
+	return (phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] &
+		MV_PHY_ALASKA_NBT_QUIRK_MASK) == MV_PHY_ALASKA_NBT_QUIRK_REV;
+}
+
 static int mv3310_config_init(struct phy_device *phydev)
 {
 	/* Check that the PHY interface type is compatible */
@@ -261,6 +281,21 @@ static int mv3310_get_features(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	if (mv3310_has_pma_ngbaset_quirk(phydev)) {
+		val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD,
+				   MDIO_PMA_NG_EXTABLE);
+		if (val < 0)
+			return val;
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				 phydev->supported,
+				 val & MDIO_PMA_NG_EXTABLE_2_5GBT);
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+				 phydev->supported,
+				 val & MDIO_PMA_NG_EXTABLE_5GBT);
+	}
+
 	return 0;
 }
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
