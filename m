From: jon.mason@broadcom.com (Jon Mason)
Date: Wed, 11 May 2016 18:56:09 -0400
Subject: [PATCH 2/2] arm64: dts: NS2: Add CCI-400 PMU support
In-Reply-To: <1463007369-13071-1-git-send-email-jonmason@broadcom.com>
References: <1463007369-13071-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1463007369-13071-2-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to the Northstar 2 Device tree file for the ARM CCI-400 PMU.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index c77a9e8..d1dc812 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -279,6 +279,26 @@
 				      IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		cci at 65590000 {
+			compatible = "arm,cci-400";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x65590000 0x1000>;
+			ranges = <0 0x65590000 0x10000>;
+
+			pmu at 9000 {
+				compatible = "arm,cci-400-pmu,r1",
+					     "arm,cci-400-pmu";
+				reg = <0x9000 0x4000>;
+				interrupts = <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		timer0: timer at 66030000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x66030000 0x1000>;
-- 
1.9.1
