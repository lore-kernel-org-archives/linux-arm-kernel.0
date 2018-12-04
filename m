Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAA1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:05:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 343112082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jKmia9Wg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343112082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HBYH1/iBQQWCuAohUbEDJtho+B1opp8ilSaDOLqLF5I=; b=jKmia9WgXDRhED
	Z4es3d6eYEYwtxVpz+ziNjCtyXFa/sdAne3tvrJqM0fM9QmAn5aBuiNARf9GHTK3yD8h8PGaLTA8T
	upyZ4bKFhWBX+RGYhRp22mmxJZ7Gn1MIaSJbq0l+bOY7qbWSCdbmUPZESxXhMASW+siWVkuibf2N1
	Jlg9pYGwPnTW9Q5GaZKSf7gKqWUJy2pFcRafEiiRNkEuAs2O5Z9aiQITXK6omjKx+euvtdvanalE9
	VazEq8dC5OyHo1e0xf4AXBBue219NhaM3Te/U9fsSq5wax/dRip5g933vwSeUWG7guWzrKwnaHyFe
	HBcncxZZ2cKgHlaPvvqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUG0e-0004Vd-UQ; Tue, 04 Dec 2018 19:05:28 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFzM-0001jJ-IP
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:04:14 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 33F3A20A35; Tue,  4 Dec 2018 20:03:56 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id BD29020A44;
 Tue,  4 Dec 2018 20:03:40 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v3 6/6] arm64: dts: marvell: add interrupt support to cp110
 thermal node
Date: Tue,  4 Dec 2018 20:03:32 +0100
Message-Id: <20181204190332.10351-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204190332.10351-1-miquel.raynal@bootlin.com>
References: <20181204190332.10351-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_110409_239483_9CAB60E4 
X-CRM114-Status: GOOD (  14.99  )
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
 linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Marc Zyngier <marc.zyngier@arm.com>,
 David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add interrupt properties in the thermal node as well as a critical trip
point in the thermal-zone.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index b9d9f31e3ba1..4d6e4a097f72 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -28,12 +28,19 @@
 	 */
 	thermal-zones {
 		CP110_LABEL(thermal_ic): CP110_NODE_NAME(thermal-ic) {
-			polling-delay-passive = <1000>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>; /* Interrupt driven */
+			polling-delay = <0>; /* Interrupt driven */
 
 			thermal-sensors = <&CP110_LABEL(thermal) 0>;
 
-			trips {	};
+			trips {
+				CP110_LABEL(crit): crit {
+					temperature = <100000>; /* mC degrees */
+					hysteresis = <2000>; /* mC degrees */
+					type = "critical";
+				};
+			};
+
 			cooling-maps { };
 		};
 	};
@@ -259,6 +266,8 @@
 			CP110_LABEL(thermal): thermal-sensor@70 {
 				compatible = "marvell,armada-cp110-thermal";
 				reg = <0x70 0x10>;
+				interrupts-extended =
+					<&CP110_LABEL(icu_sei) 116 IRQ_TYPE_LEVEL_HIGH>;
 				#thermal-sensor-cells = <1>;
 			};
 		};
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
