From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  7 Feb 2018 14:32:55 +0000
Subject: [PATCH 2/2] arm64: dts: juno: Describe the full GICv2m region
In-Reply-To: <20180207143255.17003-1-marc.zyngier@arm.com>
References: <20180207143255.17003-1-marc.zyngier@arm.com>
Message-ID: <20180207143255.17003-3-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robin Murphy <robin.murphy@arm.com>

Juno's GICv2m implementation consists of four frames providing 32
interrupts each. Since it is possible to plug in enough PCIe endpoints
to consume more than 32 MSIs, and the driver already has a bodge to
handle multiple frames, let's expose the other three as well.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index f165f04db0c9..f8088c45b060 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -68,11 +68,30 @@
 		interrupt-controller;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
 		ranges = <0 0 0 0x2c1c0000 0 0x40000>;
+
 		v2m_0: v2m at 0 {
 			compatible = "arm,gic-v2m-frame";
 			msi-controller;
 			reg = <0 0 0 0x1000>;
 		};
+
+		v2m at 10000 {
+			compatible = "arm,gic-v2m-frame";
+			msi-controller;
+			reg = <0 0x10000 0 0x1000>;
+		};
+
+		v2m at 20000 {
+			compatible = "arm,gic-v2m-frame";
+			msi-controller;
+			reg = <0 0x20000 0 0x1000>;
+		};
+
+		v2m at 30000 {
+			compatible = "arm,gic-v2m-frame";
+			msi-controller;
+			reg = <0 0x30000 0 0x1000>;
+		};
 	};
 
 	timer {
-- 
2.14.2
