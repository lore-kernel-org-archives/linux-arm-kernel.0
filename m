Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC5BC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:56:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A4C2184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jNKQf6KW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A4C2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=lDAEjC3yZH8fGh4wv5mPifkbb4kBQef8sSjO7G4sVps=; b=jNK
	Qf6KWM70Ik9kLl+NnXlj11qT1juO7pf0UY4n3VbDVdr26zsWhoA4dM1S0rM9aI3pYjSeS6RC20qtu
	1Wqc+aaTSlmjE59nbKLltxDMEJZwvT86c93AhMgy1Yr4Ug3n5pSyQPKiTzZOGetv8VjTiQfKWibcl
	DzOoOc/328k/vzJjgxF1FzWFrFxXs5bdnPvEnnytCwg3mVUcTF+B6hlOeY0xN+3rSvIP1XwnkUCtl
	Jkk+vAevb1K9+XCwoZxes3duqaEXHwsOkPf087289Fk1JqB06+oLtxZvn745iZ0WM8gmtO4q9hyR9
	jakTcdIq3DlVfN8lrMhziyuAdq4D7HQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn5iP-0000X2-6a; Fri, 25 Jan 2019 17:56:29 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn5iC-0000Lw-4V
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 17:56:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6548FEBD;
 Fri, 25 Jan 2019 09:56:15 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C9BB3F5AF;
 Fri, 25 Jan 2019 09:56:14 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] arm64: dts: juno/fast models: using GIC macros instead of
 hardcoded values
Date: Fri, 25 Jan 2019 17:56:03 +0000
Message-Id: <20190125175606.6607-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_095616_192735_261FD2A1 
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
Cc: devicetree@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There are macros that exist to indicate the GIC specific flags and
custom cell values as per the GIC DT bindings. It's used in most of the
places in these DTS files but not all. To maintain consistency, lets
use the macros at all the places.

Since DTC doesn't even warn is any cells are missing, it's very hard to
debug if that's the case. Changing to use macros avoids missing cells/
columns.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 .../boot/dts/arm/foundation-v8-gicv2.dtsi     |   2 +-
 .../boot/dts/arm/foundation-v8-gicv3.dtsi     |   2 +-
 arch/arm64/boot/dts/arm/foundation-v8.dtsi    | 106 +++++++++---------
 arch/arm64/boot/dts/arm/juno-base.dtsi        |  38 +++----
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts    | 106 +++++++++---------
 5 files changed, 129 insertions(+), 125 deletions(-)

Hi,

Found this annoying when someone making use of motherboard.dtsi to
support new platform missed the parent address cells for gic. None of
the motherboard interrupts were working. So to avoid the same issue
happening in future, moved them to use macros that is quite easy to
follow.

Regards,
Sudeep

diff --git a/arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi b/arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi
index 851abf34fc80..15fe81738e94 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi
+++ b/arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi
@@ -14,6 +14,6 @@
 		      <0x0 0x2c002000 0 0x2000>,
 		      <0x0 0x2c004000 0 0x2000>,
 		      <0x0 0x2c006000 0 0x2000>;
-		interrupts = <1 9 0xf04>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 };
diff --git a/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi b/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi
index 91fc5c60d88b..f2c75c756039 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi
+++ b/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi
@@ -17,7 +17,7 @@
 			<0x0 0x2c000000 0x0 0x2000>,
 			<0x0 0x2c010000 0x0 0x2000>,
 			<0x0 0x2c02f000 0x0 0x2000>;
-		interrupts = <1 9 4>;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 
 		its: its@2f020000 {
 			compatible = "arm,gic-v3-its";
diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dtsi b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
index e080277d27ae..3f78373f708a 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dtsi
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
@@ -7,6 +7,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
 /memreserve/ 0x80000000 0x00010000;
 
 / {
@@ -67,26 +69,26 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <1 13 0xf08>,
-			     <1 14 0xf08>,
-			     <1 11 0xf08>,
-			     <1 10 0xf08>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		clock-frequency = <100000000>;
 	};
 
 	pmu {
 		compatible = "arm,armv8-pmuv3";
-		interrupts = <0 60 4>,
-			     <0 61 4>,
-			     <0 62 4>,
-			     <0 63 4>;
+		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	watchdog@2a440000 {
 		compatible = "arm,sbsa-gwdt";
 		reg = <0x0 0x2a440000 0 0x1000>,
 			<0x0 0x2a450000 0 0x1000>;
-		interrupts = <0 27 4>;
+		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 		timeout-sec = <30>;
 	};
 
@@ -105,49 +107,49 @@
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 63>;
-		interrupt-map = <0 0  0 &gic 0 0 0  0 4>,
-				<0 0  1 &gic 0 0 0  1 4>,
-				<0 0  2 &gic 0 0 0  2 4>,
-				<0 0  3 &gic 0 0 0  3 4>,
-				<0 0  4 &gic 0 0 0  4 4>,
-				<0 0  5 &gic 0 0 0  5 4>,
-				<0 0  6 &gic 0 0 0  6 4>,
-				<0 0  7 &gic 0 0 0  7 4>,
-				<0 0  8 &gic 0 0 0  8 4>,
-				<0 0  9 &gic 0 0 0  9 4>,
-				<0 0 10 &gic 0 0 0 10 4>,
-				<0 0 11 &gic 0 0 0 11 4>,
-				<0 0 12 &gic 0 0 0 12 4>,
-				<0 0 13 &gic 0 0 0 13 4>,
-				<0 0 14 &gic 0 0 0 14 4>,
-				<0 0 15 &gic 0 0 0 15 4>,
-				<0 0 16 &gic 0 0 0 16 4>,
-				<0 0 17 &gic 0 0 0 17 4>,
-				<0 0 18 &gic 0 0 0 18 4>,
-				<0 0 19 &gic 0 0 0 19 4>,
-				<0 0 20 &gic 0 0 0 20 4>,
-				<0 0 21 &gic 0 0 0 21 4>,
-				<0 0 22 &gic 0 0 0 22 4>,
-				<0 0 23 &gic 0 0 0 23 4>,
-				<0 0 24 &gic 0 0 0 24 4>,
-				<0 0 25 &gic 0 0 0 25 4>,
-				<0 0 26 &gic 0 0 0 26 4>,
-				<0 0 27 &gic 0 0 0 27 4>,
-				<0 0 28 &gic 0 0 0 28 4>,
-				<0 0 29 &gic 0 0 0 29 4>,
-				<0 0 30 &gic 0 0 0 30 4>,
-				<0 0 31 &gic 0 0 0 31 4>,
-				<0 0 32 &gic 0 0 0 32 4>,
-				<0 0 33 &gic 0 0 0 33 4>,
-				<0 0 34 &gic 0 0 0 34 4>,
-				<0 0 35 &gic 0 0 0 35 4>,
-				<0 0 36 &gic 0 0 0 36 4>,
-				<0 0 37 &gic 0 0 0 37 4>,
-				<0 0 38 &gic 0 0 0 38 4>,
-				<0 0 39 &gic 0 0 0 39 4>,
-				<0 0 40 &gic 0 0 0 40 4>,
-				<0 0 41 &gic 0 0 0 41 4>,
-				<0 0 42 &gic 0 0 0 42 4>;
+		interrupt-map = <0 0  0 &gic 0 0 GIC_SPI  0 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  1 &gic 0 0 GIC_SPI  1 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  2 &gic 0 0 GIC_SPI  2 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  3 &gic 0 0 GIC_SPI  3 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  4 &gic 0 0 GIC_SPI  4 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  5 &gic 0 0 GIC_SPI  5 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  6 &gic 0 0 GIC_SPI  6 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  7 &gic 0 0 GIC_SPI  7 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  8 &gic 0 0 GIC_SPI  8 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  9 &gic 0 0 GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 10 &gic 0 0 GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 11 &gic 0 0 GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 12 &gic 0 0 GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 13 &gic 0 0 GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 14 &gic 0 0 GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 15 &gic 0 0 GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 16 &gic 0 0 GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 17 &gic 0 0 GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 18 &gic 0 0 GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 19 &gic 0 0 GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 20 &gic 0 0 GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 21 &gic 0 0 GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 22 &gic 0 0 GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 23 &gic 0 0 GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 24 &gic 0 0 GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 25 &gic 0 0 GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 26 &gic 0 0 GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 27 &gic 0 0 GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 28 &gic 0 0 GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 29 &gic 0 0 GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 30 &gic 0 0 GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 31 &gic 0 0 GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 32 &gic 0 0 GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 33 &gic 0 0 GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 34 &gic 0 0 GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 35 &gic 0 0 GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 36 &gic 0 0 GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 37 &gic 0 0 GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 38 &gic 0 0 GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 39 &gic 0 0 GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 40 &gic 0 0 GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 41 &gic 0 0 GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 42 &gic 0 0 GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 
 		ethernet@2,02000000 {
 			compatible = "smsc,lan91c111";
diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index ed774ee8f659..3a72c04247cb 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -18,7 +18,7 @@
 		status = "disabled";
 		frame@2a830000 {
 			frame-number = <1>;
-			interrupts = <0 60 4>;
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0x2a830000 0x0 0x10000>;
 		};
 	};
@@ -520,10 +520,10 @@
 			 <0x42000000 0x40 0x00000000 0x40 0x00000000 0x1 0x00000000>;
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 1 &gic 0 0 0 136 4>,
-				<0 0 0 2 &gic 0 0 0 137 4>,
-				<0 0 0 3 &gic 0 0 0 138 4>,
-				<0 0 0 4 &gic 0 0 0 139 4>;
+		interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 2 &gic 0 0 GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 3 &gic 0 0 GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 4 &gic 0 0 GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
 		msi-parent = <&v2m_0>;
 		status = "disabled";
 		iommu-map-mask = <0x0>;	/* RC has no means to output PCI RID */
@@ -787,19 +787,19 @@
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 15>;
-		interrupt-map = <0 0  0 &gic 0 0 0  68 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0  1 &gic 0 0 0  69 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0  2 &gic 0 0 0  70 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0  3 &gic 0 0 0 160 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0  4 &gic 0 0 0 161 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0  5 &gic 0 0 0 162 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0  6 &gic 0 0 0 163 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0  7 &gic 0 0 0 164 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0  8 &gic 0 0 0 165 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0  9 &gic 0 0 0 166 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 10 &gic 0 0 0 167 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 11 &gic 0 0 0 168 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 12 &gic 0 0 0 169 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map = <0 0  0 &gic 0 0 GIC_SPI  68 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  1 &gic 0 0 GIC_SPI  69 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  2 &gic 0 0 GIC_SPI  70 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  3 &gic 0 0 GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  4 &gic 0 0 GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  5 &gic 0 0 GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  6 &gic 0 0 GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  7 &gic 0 0 GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  8 &gic 0 0 GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  9 &gic 0 0 GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 10 &gic 0 0 GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 11 &gic 0 0 GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 12 &gic 0 0 GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	site2: tlx@60000000 {
@@ -809,6 +809,6 @@
 		ranges = <0 0 0x60000000 0x10000000>;
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0>;
-		interrupt-map = <0 0 &gic 0 0 0 168 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map = <0 0 &gic 0 0 GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 	};
 };
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
index fe4fda473c0a..6e685d883303 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
@@ -10,6 +10,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
 /memreserve/ 0x80000000 0x00010000;
 
 #include "rtsm_ve-motherboard.dtsi"
@@ -101,24 +103,24 @@
 		      <0x0 0x2c002000 0 0x2000>,
 		      <0x0 0x2c004000 0 0x2000>,
 		      <0x0 0x2c006000 0 0x2000>;
-		interrupts = <1 9 0xf04>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <1 13 0xf08>,
-			     <1 14 0xf08>,
-			     <1 11 0xf08>,
-			     <1 10 0xf08>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		clock-frequency = <100000000>;
 	};
 
 	pmu {
 		compatible = "arm,armv8-pmuv3";
-		interrupts = <0 60 4>,
-			     <0 61 4>,
-			     <0 62 4>,
-			     <0 63 4>;
+		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	panel {
@@ -144,48 +146,48 @@
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 63>;
-		interrupt-map = <0 0  0 &gic 0  0 4>,
-				<0 0  1 &gic 0  1 4>,
-				<0 0  2 &gic 0  2 4>,
-				<0 0  3 &gic 0  3 4>,
-				<0 0  4 &gic 0  4 4>,
-				<0 0  5 &gic 0  5 4>,
-				<0 0  6 &gic 0  6 4>,
-				<0 0  7 &gic 0  7 4>,
-				<0 0  8 &gic 0  8 4>,
-				<0 0  9 &gic 0  9 4>,
-				<0 0 10 &gic 0 10 4>,
-				<0 0 11 &gic 0 11 4>,
-				<0 0 12 &gic 0 12 4>,
-				<0 0 13 &gic 0 13 4>,
-				<0 0 14 &gic 0 14 4>,
-				<0 0 15 &gic 0 15 4>,
-				<0 0 16 &gic 0 16 4>,
-				<0 0 17 &gic 0 17 4>,
-				<0 0 18 &gic 0 18 4>,
-				<0 0 19 &gic 0 19 4>,
-				<0 0 20 &gic 0 20 4>,
-				<0 0 21 &gic 0 21 4>,
-				<0 0 22 &gic 0 22 4>,
-				<0 0 23 &gic 0 23 4>,
-				<0 0 24 &gic 0 24 4>,
-				<0 0 25 &gic 0 25 4>,
-				<0 0 26 &gic 0 26 4>,
-				<0 0 27 &gic 0 27 4>,
-				<0 0 28 &gic 0 28 4>,
-				<0 0 29 &gic 0 29 4>,
-				<0 0 30 &gic 0 30 4>,
-				<0 0 31 &gic 0 31 4>,
-				<0 0 32 &gic 0 32 4>,
-				<0 0 33 &gic 0 33 4>,
-				<0 0 34 &gic 0 34 4>,
-				<0 0 35 &gic 0 35 4>,
-				<0 0 36 &gic 0 36 4>,
-				<0 0 37 &gic 0 37 4>,
-				<0 0 38 &gic 0 38 4>,
-				<0 0 39 &gic 0 39 4>,
-				<0 0 40 &gic 0 40 4>,
-				<0 0 41 &gic 0 41 4>,
-				<0 0 42 &gic 0 42 4>;
+		interrupt-map = <0 0  0 &gic GIC_SPI  0 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  1 &gic GIC_SPI  1 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  2 &gic GIC_SPI  2 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  3 &gic GIC_SPI  3 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  4 &gic GIC_SPI  4 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  5 &gic GIC_SPI  5 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  6 &gic GIC_SPI  6 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  7 &gic GIC_SPI  7 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  8 &gic GIC_SPI  8 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0  9 &gic GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 10 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 11 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 12 &gic GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 13 &gic GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 14 &gic GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 15 &gic GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 16 &gic GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 17 &gic GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 18 &gic GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 19 &gic GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 20 &gic GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 21 &gic GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 22 &gic GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 23 &gic GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 24 &gic GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 25 &gic GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 26 &gic GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 27 &gic GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 28 &gic GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 29 &gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 30 &gic GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 31 &gic GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 32 &gic GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 33 &gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 34 &gic GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 35 &gic GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 36 &gic GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 37 &gic GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 38 &gic GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 39 &gic GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 40 &gic GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 41 &gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 42 &gic GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 	};
 };
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
