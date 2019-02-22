Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A261C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:38:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5792075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u/27SWzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5792075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sRPm0CVQ1JIF0CNpbCJIMiS53Q+CzagMAbwRaGyEZbE=; b=u/27SWzUMnItir
	aPnID3pqPfBzQ5ryDsI6AMxXk9XxQJ1X5trlov+tz9RXT2xrbdgcmpn00M0jVcWfRxNtWkXIjnYqs
	yaKayWMoVlyqNTh29TzJEpOaJ/+X+fGm9Tt46k3vF1a2TKLyYwGRg5d2XdoKp1+cVYBBINwi9o9UN
	KJ9uC2JAOurEcWLcuj0ykp5udn4uenvNaSJC7n4ZcxdREBHzTv4UnfHM+JyWuPbYu3zKwWV7kaOUe
	rmQrLIe63TORTs/faZiDBkPn+Odh/6w6fjyMvIpeKMQWzbKj6Q0L6L0Sj9ny1oIIRPUQI52kTFs3y
	n7w+Yarzoq7h4NHHZqXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxKOM-00024q-C3; Fri, 22 Feb 2019 23:38:06 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxKOI-00023A-7E
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 23:38:04 +0000
X-Originating-IP: 86.201.231.99
Received: from mc-bl-xps13.lan (lfbn-tou-1-149-99.w86-201.abo.wanadoo.fr
 [86.201.231.99])
 (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2E1DB6000B;
 Fri, 22 Feb 2019 23:37:47 +0000 (UTC)
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Subject: [PATCH net-next v2 0/7] net: phy: marvell10g: Add 2.5GBaseT support
Date: Sat, 23 Feb 2019 00:37:37 +0100
Message-Id: <20190222233744.25735-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_153802_422778_643AB5BB 
X-CRM114-Status: GOOD (  10.82  )
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

This series adds the missing bits necessary to fully support 2.5GBaseT
in the Marvell Alaska PHYs.

The main points for that support are :

 - Making use of the .get_features call, recently introduced by Heiner
   and Andrew, that allows having a fully populated list of supported
   modes, including 2500BaseT.  

 - Configuring the MII to 2500BaseX when establishing a link at 2.5G

 - Adding a small quirk to take into account the fact that some PHYs in
   the family won't report the correct supported abilities

The rest of the series consists of small cosmetic improvements such as
using the correct helper to set a linkmode bit and adding macros for the
PHY ids.

We also add support for the 88E2110 PHY, which doesn't require the
quirk, and support for 2500BaseT in the PPv2 driver, in order to have a
fully working setup on the MacchiatoBin board.

Changes since V1 : Fixed formatting issue in patch 01, rebased.

Maxime Chevallier (7):
  net: phy: marvell10g: Use get_features to get the PHY abilities
  net: phy: marvell10g: Use linkmode_set_bit helper instead of __set_bit
  net: phy: marvell10g: Use 2500BASEX when using 2.5GBASET
  net: phy: marvell10g: Use a #define for 88X3310 family id
  net: phy: marvell10g: Force reading of 2.5/5G
  net: mvpp2: Add 2.5GBaseT support
  net: phy: marvell10g: add support for the 88x2110 PHY

 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  1 +
 drivers/net/phy/marvell10g.c                  | 93 ++++++++++++++++---
 include/linux/marvell_phy.h                   |  2 +
 3 files changed, 82 insertions(+), 14 deletions(-)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
