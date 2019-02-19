Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECA5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:22:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03D52147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nsr4UR4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03D52147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TsRWo4ghQYEhwN3NYx9mJutJh2Fh0zlQYnr4fEq+EUc=; b=nsr4UR4adCa6dm
	2A3RkKhdqOKaPN0bfLJkjDNhnEPqumpgr07c98m4iF5O2evp4QrGiNtE0W/uh8HSbJVV6vfJ7E4PI
	5ZMlSQOi18hynHx4pR8ksM0EGKoPF7okoTNRGZU+Qv7Kma6U97xzVmIX3YTTm9JAvvk0VxewV2Sgh
	Xe1T+tk2A3X3gixIvkS5u4D+qnR9d0f0x4I40vsQ5ZfEgAXr+xS1Glw5bdaPfQ33AHVWjWOw1D/VL
	mcufdlv+DFydGgtBZQMC6Gf2cXq6oZFnv+7m3qhKzCuk5ee9OCffojMWl2wZmsr35ZBH2zAr5Oxg9
	Wu7ugYrukD7hUr8wMSkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw8AS-0002MH-4g; Tue, 19 Feb 2019 16:22:48 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw8AK-0002M0-Ph
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 16:22:46 +0000
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr
 [90.53.137.203]) (Authenticated sender: gregory.clement@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 7110D100019;
 Tue, 19 Feb 2019 16:22:33 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH] arch: arm: dts: kirkwood-rd88f6281: Remove disabled marvell,
 dsa reference
Date: Tue, 19 Feb 2019 17:22:25 +0100
Message-Id: <20190219162225.16453-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_082240_982796_B81D219E 
X-CRM114-Status: UNSURE (   7.66  )
X-CRM114-Notice: Please train this message.
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

marvell,dsa properties has been removed from kirkwood-rd88f6281.dtsi
while cleanuping the dsa binding, but the dsa reference in
kirkwood-rd88f6281-z0.dts has been missed causing the following errors:

arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts:21.4-16: Warning (reg_format): /dsa/switch@0:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts:23.5-15: Warning (reg_format): /dsa/switch@0/port@4:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/kirkwood-rd88f6281-z0.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/kirkwood-rd88f6281-z0.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/kirkwood-rd88f6281-z0.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts:20.12-26.5: Warning (avoid_default_addr_size): /dsa/switch@0: Relying on default #address-cells value
arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts:20.12-26.5: Warning (avoid_default_addr_size): /dsa/switch@0: Relying on default #size-cells value
arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts:22.11-25.6: Warning (avoid_default_addr_size): /dsa/switch@0/port@4: Relying on default #address-cells value
arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts:22.11-25.6: Warning (avoid_default_addr_size): /dsa/switch@0/port@4: Relying on default #size-cells value

So remove the dsa reference too in order to fix this issue.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts b/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
index a9fee2c2bcaf..9d88301daf0e 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
+++ b/arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts
@@ -16,15 +16,6 @@
 	model = "Marvell RD88f6281 Reference design, with Z0 SoC";
 	compatible = "marvell,rd88f6281-z0", "marvell,rd88f6281","marvell,kirkwood-88f6281", "marvell,kirkwood";
 
-	dsa {
-		switch@0 {
-			reg = <0 0>;    /* MDIO address 0, switch 0 in tree */
-			port@4 {
-				reg = <4>;
-				label = "wan";
-			};
-		};
-	};
 };
 
 &eth1 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
