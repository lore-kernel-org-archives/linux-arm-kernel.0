From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 17 Apr 2018 18:06:00 +0530
Subject: [PATCH] ARM: dts: da850: fix W=1 warnings with pinmux node
Message-ID: <20180417123600.23548-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused #address-cells and #size-cells from pinmux
node. This fixes W=1 warnings of the type:

arch/arm/boot/dts/da850-lcdk.dtb: Warning (avoid_unnecessary_addr_size): /soc at 1c00000/pinmux at 14120: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Tested on DA850 LCDK by checking output of:

/sys/kernel/debug/pinctrl/1c14120.pinmux-pinctrl-single/pins

before and after the change.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/da850.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index cba3afd00763..f6f1597b03df 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -55,8 +55,6 @@
 		pmx_core: pinmux at 14120 {
 			compatible = "pinctrl-single";
 			reg = <0x14120 0x50>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			#pinctrl-cells = <2>;
 			pinctrl-single,bit-per-mux;
 			pinctrl-single,register-width = <32>;
-- 
2.16.2
