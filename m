Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D9DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:05:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A332082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n3+gHHq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A332082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XMuDfgzRhTaEOmAvk9E2yuH2r+FXOPuAxz5ODn7Dubo=; b=n3+gHHq58VhftG
	uwYJpr91hmb4bFpLpLrTkl5FgyJxVnDpH5FKqz2KO1MgNN8lTdYgXNA/W+4Ld6isH3thaxDDq5WWn
	NL34ZSxHPG0rKJIeD4V5KoiXpqaGMB5wP3PXWpR0LTC4z3Knu+F1cKvcDTncwaKfxCtI4DaDeFpcN
	MzyoULAaw401wpK6iGUhRBLmS9I81D43K16kG+aYgrXUf8C3dZJajF9HBkm0Z1yOGklfjV6cMBHv2
	ihSXoXd7PExQw9IubbIbcNf17lgsgBOmtd/BRnqK339MMGaE0JxRSc1Pzc0wgST527NPlI3qPVkvB
	Hz9KHFhr1Pyz2aa5pWWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUG0O-0003Lt-Ua; Tue, 04 Dec 2018 19:05:12 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFzM-0001jL-IR
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:04:13 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 2C42B2087D; Tue,  4 Dec 2018 20:03:56 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id 889B720A35;
 Tue,  4 Dec 2018 20:03:39 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v3 5/6] arm64: dts: marvell: add interrupt support to ap806
 thermal node
Date: Tue,  4 Dec 2018 20:03:31 +0100
Message-Id: <20181204190332.10351-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204190332.10351-1-miquel.raynal@bootlin.com>
References: <20181204190332.10351-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_110409_128985_DEAAA5E0 
X-CRM114-Status: GOOD (  15.25  )
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
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 073610ac0a53..70b244a4c4c2 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -293,6 +293,8 @@
 				ap_thermal: thermal-sensor@80 {
 					compatible = "marvell,armada-ap806-thermal";
 					reg = <0x80 0x10>;
+					interrupt-parent = <&sei>;
+					interrupts = <18>;
 					#thermal-sensor-cells = <1>;
 				};
 			};
@@ -303,16 +305,26 @@
 	 * The thermal IP features one internal sensor plus, if applicable, one
 	 * remote channel wired to one sensor per CPU.
 	 *
+	 * Only one thermal zone per AP/CP may trigger interrupts at a time, the
+	 * first one that will have a critical trip point will be chosen.
+	 *
 	 * The cooling maps are always empty as there are no cooling devices.
 	 */
 	thermal-zones {
 		ap_thermal_ic: ap-thermal-ic {
-			polling-delay-passive = <1000>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>; /* Interrupt driven */
+			polling-delay = <0>; /* Interrupt driven */
 
 			thermal-sensors = <&ap_thermal 0>;
 
-			trips {	};
+			trips {
+				ap_crit: ap-crit {
+					temperature = <100000>; /* mC degrees */
+					hysteresis = <2000>; /* mC degrees */
+					type = "critical";
+				};
+			};
+
 			cooling-maps { };
 		};
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
