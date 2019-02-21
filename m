Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6B3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:53:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA9E20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rTcAAFsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA9E20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WbMiWZYqRIOePOhztDz3t0QvRdoU7hO7WDdKWR9037A=; b=rTcAAFsfNICput
	cObOUXW9OpZpC06Fv589zrgh1Ft17GLlBrCyahEvPhJTLnQLcovgUWxqyzOMjmOKtY6PVRaXQJ2Id
	ZbzpyUA0LUt2hOV71DQl5vZSA4jU8hFgYZPGE4Dh9U2nopunS+/3ELlKC8xdBV8mJBiO5DTBIWm0R
	Y97P96CL0bJ/dXv/X7Hm4EGMCsyi2o7SwL8OcWf87hupu/VBGDR26ntSyv1+ZaxNvp4PNx2SFAPS/
	ruRs5o3pLVRtnyUDbW8PK/nW84VcqeuSEhHXThdNNPV4apV6jJjj9BxQCe5xhQVfQ1fzZmrEVPoPO
	/9uD/qQ6yWe8XCkAlNmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwl2R-0002mj-Gr; Thu, 21 Feb 2019 09:53:07 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwl1H-0001LK-2k
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 09:52:05 +0000
X-Originating-IP: 90.88.23.190
Received: from mc-bl-xps13.lan
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 10512C000A;
 Thu, 21 Feb 2019 09:51:50 +0000 (UTC)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next 7/7] net: phy: marvell10g: add support for the
 88x2110 PHY
Date: Thu, 21 Feb 2019 10:51:28 +0100
Message-Id: <20190221095128.28188-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190221095128.28188-1-maxime.chevallier@bootlin.com>
References: <20190221095128.28188-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_015155_966782_47554F3E 
X-CRM114-Status: GOOD (  12.42  )
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
 drivers/net/phy/marvell10g.c | 13 +++++++++++++
 include/linux/marvell_phy.h  |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index c48669d50653..bac199b7540f 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -490,12 +490,25 @@ static struct phy_driver mv3310_drivers[] = {
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
index 70c17345e118..73d04743a2bb 100644
--- a/include/linux/marvell_phy.h
+++ b/include/linux/marvell_phy.h
@@ -21,6 +21,7 @@
 #define MARVELL_PHY_ID_88E1545		0x01410ea0
 #define MARVELL_PHY_ID_88E3016		0x01410e60
 #define MARVELL_PHY_ID_88X3310		0x002b09a0
+#define MARVELL_PHY_ID_88E2110		0x002b09b0
 
 /* The MV88e6390 Ethernet switch contains embedded PHYs. These PHYs do
  * not have a model ID. So the switch driver traps reads to the ID2
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
