Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173DFC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:48:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C3A20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jt2u7Hs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C3A20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wkp1tFURU7fBzD6an0DxLWDelfRHpZXDPe5lLiQrCoQ=; b=jt2u7Hs4o6Bngo
	Ussl9M6R8PoH+GTuGHuYwuCKCc9ZP4J9UDiiFHNyKOX75DxgDqq7MpvVuohEWhKSP/TrGEbRWLVH4
	+TF4jBKHqEGK2F3uU4kQoodFZ2CdpmtUw6HLB/HkHSEyeFG9uYjd3mjPOMwmFb78b2wOCPNMxpfNj
	F8S5qxtw77VQIfjEe9UHYW5o0vXpWUV/D4yjuLMFV2tT0DOetlNWkIPsPhvH1PU8U3VMyHgwXerTe
	Y714PSfdhHhdm0A8DMJWZ/WBjTIK1WWLhEs3bjwN44QUPeGfznpmSGI1orkx4zu7tqfvdeQ32D5wf
	asVulUg725T05w5MTIJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSk5g-00080l-96; Fri, 30 Nov 2018 14:48:24 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSk5T-0007o7-7w
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 14:48:13 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 72F6C20D23; Fri, 30 Nov 2018 15:47:55 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 153B220CFA;
 Fri, 30 Nov 2018 15:47:45 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 1/8] phy: mvebu-cp110-comphy: fix spelling in structure name
Date: Fri, 30 Nov 2018 15:47:36 +0100
Message-Id: <20181130144743.675-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130144743.675-1-miquel.raynal@bootlin.com>
References: <20181130144743.675-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_064811_420870_499E81CF 
X-CRM114-Status: GOOD (  13.71  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Grzegorz Jaszczyk <jaz@semihalf.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Marcin Wojtas <mw@semihalf.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Rename the mvebu_comhy_conf structure to be mvebu_comphy_conf, which is
probably what the original author meant.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
index 86a5f7b9448b..31b9a1c18345 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
@@ -114,7 +114,7 @@
 #define MVEBU_COMPHY_LANES	6
 #define MVEBU_COMPHY_PORTS	3
 
-struct mvebu_comhy_conf {
+struct mvebu_comphy_conf {
 	enum phy_mode mode;
 	unsigned lane;
 	unsigned port;
@@ -129,7 +129,7 @@ struct mvebu_comhy_conf {
 		.mux = _mux,				\
 	}
 
-static const struct mvebu_comhy_conf mvebu_comphy_cp110_modes[] = {
+static const struct mvebu_comphy_conf mvebu_comphy_cp110_modes[] = {
 	/* lane 0 */
 	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_SGMII, 0x1),
 	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_2500SGMII, 0x1),
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
