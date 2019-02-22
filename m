Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A501DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:39:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FCA6206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fpX0TI9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCA6206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HuvORGRp1zICd/gl99itS9HdeCj0txlFmHQp5PKXoEA=; b=fpX0TI9ywO/GiO
	0fDN83JuCIDowIJBkbyXknPPZwSbJyqdaXD8VWM152PrMDjmLKtvWdG1jPZ77F5A35+rDAUgzuOK2
	wDiIYbJfhv1I7dOalYWJsk9DoM+Raq4UQx0X9MxwhPOA3P6SMCPaM0+HfJMjPC7ew/vbufbgRt0Po
	UdFXwNjBwghU8/0llh8phh6qsATZn9Gr5Qz4TySX44t4rFUEKFfNxPGuJun3MWVpOCs4if228HXuk
	2/vy2yajiSMCh+mtVfUZeie65b9M+FNZZEBTNrx2ZZnngKemeVsshZN5ejQxVkz3nKmouL+Ul5Aym
	3LBXh+gzAjSsDl9CTytw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxKPC-00035I-95; Fri, 22 Feb 2019 23:38:58 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxKOU-0002Ez-64
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 23:38:22 +0000
X-Originating-IP: 86.201.231.99
Received: from mc-bl-xps13.lan (lfbn-tou-1-149-99.w86-201.abo.wanadoo.fr
 [86.201.231.99])
 (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 978B260008;
 Fri, 22 Feb 2019 23:38:07 +0000 (UTC)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next v2 4/7] net: phy: marvell10g: Use a #define for
 88X3310 family id
Date: Sat, 23 Feb 2019 00:37:41 +0100
Message-Id: <20190222233744.25735-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190222233744.25735-1-maxime.chevallier@bootlin.com>
References: <20190222233744.25735-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_153814_957650_CE7FC571 
X-CRM114-Status: GOOD (  12.01  )
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

The PHY ID corresponding to the 88X3310 is also used for other PHYs in
the same family, such as the 88E2010. Use a #define for the PHY id, that
ignores the last nibble.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/marvell10g.c | 4 ++--
 include/linux/marvell_phy.h  | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 9342d8c2ff7f..9c0b8f16cec5 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -430,7 +430,7 @@ static int mv3310_read_status(struct phy_device *phydev)
 
 static struct phy_driver mv3310_drivers[] = {
 	{
-		.phy_id		= 0x002b09aa,
+		.phy_id		= MARVELL_PHY_ID_88X3310,
 		.phy_id_mask	= MARVELL_PHY_ID_MASK,
 		.name		= "mv88x3310",
 		.get_features	= mv3310_get_features,
@@ -448,7 +448,7 @@ static struct phy_driver mv3310_drivers[] = {
 module_phy_driver(mv3310_drivers);
 
 static struct mdio_device_id __maybe_unused mv3310_tbl[] = {
-	{ 0x002b09aa, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88X3310, MARVELL_PHY_ID_MASK },
 	{ },
 };
 MODULE_DEVICE_TABLE(mdio, mv3310_tbl);
diff --git a/include/linux/marvell_phy.h b/include/linux/marvell_phy.h
index 1eb6f244588d..70c17345e118 100644
--- a/include/linux/marvell_phy.h
+++ b/include/linux/marvell_phy.h
@@ -20,6 +20,7 @@
 #define MARVELL_PHY_ID_88E1540		0x01410eb0
 #define MARVELL_PHY_ID_88E1545		0x01410ea0
 #define MARVELL_PHY_ID_88E3016		0x01410e60
+#define MARVELL_PHY_ID_88X3310		0x002b09a0
 
 /* The MV88e6390 Ethernet switch contains embedded PHYs. These PHYs do
  * not have a model ID. So the switch driver traps reads to the ID2
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
