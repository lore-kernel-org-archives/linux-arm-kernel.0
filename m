From: jun.nie@linaro.org (Jun Nie)
Date: Wed, 12 Oct 2016 10:14:15 +0800
Subject: [PATCH 1/2] arm64: dts: zx: Change gic node to fix boot failure
Message-ID: <1476238456-20420-1-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GICR for multiple CPU can be described with start address and stride,
or with multiple address. Current multiple address and stride are
both used. Fix it.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 arch/arm64/boot/dts/zte/zx296718.dtsi | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index a223066..6b239a3 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -239,16 +239,11 @@
 		compatible = "arm,gic-v3";
 		#interrupt-cells = <3>;
 		#address-cells = <0>;
-		#redistributor-regions = <6>;
-		redistributor-stride = <0x0 0x40000>;
+		#redistributor-regions = <1>;
+		redistributor-stride = <0x20000>;
 		interrupt-controller;
 		reg = <0x02a00000 0x10000>,
-		      <0x02b00000 0x20000>,
-		      <0x02b20000 0x20000>,
-		      <0x02b40000 0x20000>,
-		      <0x02b60000 0x20000>,
-		      <0x02b80000 0x20000>,
-		      <0x02ba0000 0x20000>;
+		      <0x02b00000 0xc0000>;
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-- 
1.9.1
