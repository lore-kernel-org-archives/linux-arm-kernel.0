Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FE5C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:52:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885D720823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DOr7U54Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885D720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LZ9J/+Z+YDZCzlOo60nogHfTNE4870s5X2YOCPiKjTc=; b=DOr7U54ZsVuBiS
	mbCB7FhK9hILzMBoO4nZEccLuXURywPQ4/8aqCi/DskVDYxcSM9HqxuqMkj66Nb114WZK7mu117cd
	+07mZPvoC70rPQQU6rA+HY6KvhIRZqJ55uPL+6R2bOguX31IdssyovLGnAWsXCh6RiVGDzWgTLZNU
	NUr+d3s2KxuWNEp+smmGkVFhqvAeiOnLRi/U7Y5oIcyvne22SAYXpuWHL6yVkahZAFiiTFpsVRWxl
	r/VWbblFtl7/PxJyUCazMfb9GrrCfCNAlrGXW6XNeedg6wNU+jL3IIUh90u/jKRgI7/Cz2XJjhryq
	YB4u8pFRVVh1NJpbt+Rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grgMb-0000mX-SE; Thu, 07 Feb 2019 09:52:57 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grgKB-0006eS-FM
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 09:50:35 +0000
Received: from mc-bl-xps13.lan
 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
 (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 2F9D8100014;
 Thu,  7 Feb 2019 09:50:23 +0000 (UTC)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next v2 10/10] net: phy: marvell10g: add support for the
 88x2110 PHY
Date: Thu,  7 Feb 2019 10:49:39 +0100
Message-Id: <20190207094939.27369-11-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_015028_037262_6A45FDFF 
X-CRM114-Status: GOOD (  12.78  )
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
V1 -> V2: Use a #define for the PHY ID, since we also do that for the
	  3310. Removed the mv2110_config_init implementation since we
	  now manually check for the PMA device id when using the quirk.

 drivers/net/phy/marvell10g.c | 13 +++++++++++++
 include/linux/marvell_phy.h  |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 2593db608af7..fa4847662c81 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -508,12 +508,25 @@ static struct phy_driver mv3310_drivers[] = {
 		.aneg_done	= mv3310_aneg_done,
 		.read_status	= mv3310_read_status,
 	},
+	{
+		.phy_id		= MARVELL_PHY_ID_88E2110,
+		.phy_id_mask	= MARVELL_PHY_ID_MASK,
+		.name		= "mv88x2110",
+		.features	= PHY_10GBIT_FEATURES,
+		.probe		= mv3310_probe,
+		.soft_reset	= gen10g_no_soft_reset,
+		.config_init	= mv3310_config_init,
+		.config_aneg	= mv3310_config_aneg,
+		.aneg_done	= mv3310_aneg_done,
+		.read_status	= mv3310_read_status,
+	},
 };
 
 module_phy_driver(mv3310_drivers);
 
 static struct mdio_device_id __maybe_unused mv3310_tbl[] = {
 	{ MARVELL_PHY_ID_88X3310, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E2110, MARVELL_PHY_ID_MASK },
 	{ },
 };
 MODULE_DEVICE_TABLE(mdio, mv3310_tbl);
diff --git a/include/linux/marvell_phy.h b/include/linux/marvell_phy.h
index 5851d68d828a..8596a861940e 100644
--- a/include/linux/marvell_phy.h
+++ b/include/linux/marvell_phy.h
@@ -21,6 +21,7 @@
 #define MARVELL_PHY_ID_88E1545		0x01410ea0
 #define MARVELL_PHY_ID_88E3016		0x01410e60
 #define MARVELL_PHY_ID_88X3310		0x002b09aa
+#define MARVELL_PHY_ID_88E2110		0x002b09b8
 
 /* The MV88e6390 Ethernet switch contains embedded PHYs. These PHYs do
  * not have a model ID. So the switch driver traps reads to the ID2
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
