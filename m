From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Wed,  7 Jan 2015 12:39:30 +0530
Subject: [PATCH 2/2] ARM: dts: vfxxx: Add SNVS node
In-Reply-To: <cover.1420612799.git.maitysanchayan@gmail.com>
References: <cover.1420612799.git.maitysanchayan@gmail.com>
Message-ID: <0d159705cd56248f53c8481a37471f3c0fc14efd.1420612799.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree node for the Secure Non-Volatile Storage
(SNVS) on the VF610 platform. The SNVS block also has a
Real Time Counter (RTC).

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vf500.dtsi |    4 ++++
 arch/arm/boot/dts/vfxxx.dtsi |   14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/vf500.dtsi b/arch/arm/boot/dts/vf500.dtsi
index 2901609..0d0de864 100644
--- a/arch/arm/boot/dts/vf500.dtsi
+++ b/arch/arm/boot/dts/vf500.dtsi
@@ -130,6 +130,10 @@
 	interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&snvsrtc {
+	interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &src {
 	interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 };
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index a55e1f9..ae5c358 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -351,6 +351,20 @@
 				status = "disabled";
 			};
 
+			snvs0: snvs at 400a7000 {
+			    compatible = "fsl,sec-v4.0-mon", "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x400a7000 0x2000>;
+
+				snvsrtc: snvs-rtc-lp at 34 {
+					compatible = "fsl,sec-v4.0-mon-rtc-lp";
+					reg = <0x34 0x58>;
+					clocks = <&clks VF610_CLK_SNVS>;
+					clock-names = "snvs-rtc";
+				};
+			};
+
 			uart4: serial at 400a9000 {
 				compatible = "fsl,vf610-lpuart";
 				reg = <0x400a9000 0x1000>;
-- 
1.7.9.5
