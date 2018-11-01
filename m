From: martin@kaiser.cx (Martin Kaiser)
Date: Thu,  1 Nov 2018 18:32:47 +0100
Subject: [PATCH] ARM: dts: i.MX25: add the clocks for the EPIT blocks
Message-ID: <1541093567-29205-1-git-send-email-martin@kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX25 contains two EPIT (Enhanced Periodic Interrupt Timer)
function blocks. Add their ipg and per clocks to the device tree.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---

I tried to make this similar to gpt1 and gpt2.

 arch/arm/boot/dts/imx25.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index b25309d26ea5..e80101847aff 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -388,12 +388,16 @@
 			epit1: timer at 53f94000 {
 				compatible = "fsl,imx25-epit";
 				reg = <0x53f94000 0x4000>;
+				clocks = <&clks 83>, <&clks 43>;
+				clock-names = "ipg", "per";
 				interrupts = <28>;
 			};
 
 			epit2: timer at 53f98000 {
 				compatible = "fsl,imx25-epit";
 				reg = <0x53f98000 0x4000>;
+				clocks = <&clks 84>, <&clks 43>;
+				clock-names = "ipg", "per";
 				interrupts = <27>;
 			};
 
-- 
2.1.4
