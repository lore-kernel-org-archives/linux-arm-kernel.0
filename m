Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A8EC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A406120896
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WEvz01mH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A406120896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lzcB7nbrJELa5DJ9+6fnVDNYBQzYDLVONBSPDCawf80=; b=WEvz01mHiWXq5b
	i8VwL1/n4upauBLA+T1rCCLUssRQXOW3J6/p/1v9TeQ5GXtbARpnRxv3Xw4FFdSHrGPiOFCjnfe6r
	H+MHguIlT9U2Vu04cQwBU8MK7NCzBXtgNtbAAIgnNVlghIoek22sppaZu/VLTWdKLNeGEYHTVDkY8
	exoXwCxpi8TKhYP04duyveLKfA3cr08gvQbyBCm913PjYU30zi9Oc1901tKiSXRIoAVPI7ritHEz8
	I6OzZbE0i349Q4FUYXnPG1MBoGNb+/OoWcwoFQ1eVtB1wxICMDZ4I6GeDrg3LecQB4LvTdH9E2iy1
	ypEaqdF3JrNMHWxhP+Qg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkW0N-0000NW-1I; Fri, 18 Jan 2019 15:24:23 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkW0G-0000GI-Ok
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 15:24:20 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 0FB2420A7D; Fri, 18 Jan 2019 16:24:13 +0100 (CET)
Received: from mc-bl-xps13.lan
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id A768420797;
 Fri, 18 Jan 2019 16:24:02 +0100 (CET)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next 0/7] net: phy: Add support for 2.5GBASET PHYs
Date: Fri, 18 Jan 2019 16:23:45 +0100
Message-Id: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_072417_218951_28D16784 
X-CRM114-Status: GOOD (  16.00  )
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

Hello everyone,

This series introduces support for 2.5GBASET mode in Network PHYs, and
implements that support in some PHYs in the Marvell Alaska product
range, the PPv2 driver, and a new PHY from the Alaska family.

2.5GBASET and 5GBASET were originally defined by the NBASET alliance,
and are now being specified as an IEEE standard, under the 802.3bz
specification.

The first patch in the series generalizes the way we build the list of
supported modes in C45 PHYs, relying on the various modes exposed in the
PMA registers. It extracts the logic from the marvell10g driver.

The second patch adds the new register definitions from the 802.3bz
specifications, and adds the generic code to handle both 2.5GBASET and
5GBASET.

The third patch allows to automatically detect whether or not a PHY
supports 2.5GBASET and 5GBASET, by reading the PMA abilities.

Patches 4 and 5 add support for 2.5GBASET into the marvell10g driver,
with a workaround for incorrect abilities being reported by the 88X3310
and the 88E2010 PHYs. (see patch 5).

Patch 6 adds support for 2.5GBASET in the PPv2 ethernet driver, thus
enabling support for that mode on the MacchiatoBin.

Finally, patch 7 introduces support for the 88x2110 PHY, which is very
similar to the 88x3310, the only difference being the lack of Fiber
support. The 88x2110 already reports the correct abilities from it's
PMA, and thus doesn't require the workaround implemented in patch 5 for
2.5GBASET to work. This is based on work originally done by Antoine Tenart.

This patch series was tested on the MacchiatoBin, a custom board using a
88e2010, and another using a 88x2110.

The 88x2110 support is enclosed in the series to better show the need
for the workaround in the 88x3310, feel free to tell me if we should
handle such hardware issues in another way, or if support for that PHY
should be submitted separately.

At this point, future development adding 5GBASET to Marvell PHYs should be
straightforward, but this isn't included in the series since I lack any
hardware to test the 5GBASE-R mode that the PHY uses to connect to the
MAC in that case.

Thanks to Andrew for doing the rework of the link_mode representation
this series depends on.

Maxime Chevallier (7):
  net: phy: Extract genphy_c45_read_abilities from marvell10g
  net: phy: Add generic support for 2.5GBaseT and 5GBaseT
  net: phy: Read 2.5G and 5G extended abilities
  net: phy: marvell10g: Add support for 2.5GBASET and 5GBASET
  net: phy: marvell10g: Force reading of 2.5/5G PMA extended abilities
  net: mvpp2: Add 2.5GBaseT support
  net: phy: marvell10g: add support for the 88x2110 PHY

 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |   1 +
 drivers/net/phy/marvell10g.c                  | 155 +++++++++---------
 drivers/net/phy/phy-c45.c                     | 132 +++++++++++++++
 include/linux/phy.h                           |   1 +
 include/uapi/linux/mdio.h                     |  16 ++
 5 files changed, 226 insertions(+), 79 deletions(-)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
