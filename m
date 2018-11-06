From: anson.huang@nxp.com (Anson Huang)
Date: Tue, 6 Nov 2018 09:19:36 +0000
Subject: [PATCH] ARM: dts: imx6sll: remove unused property in gpc node
Message-ID: <1541495675-14706-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "fsl,mf-mix-wakeup-irq" is ONLY used as a temporary
solution in NXP's internal tree for Mega/Fast Mix off
feature after suspend, upstream kernel does NOT need it,
remove it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index 5ff4b99..62847c6 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -593,7 +593,6 @@
 				#interrupt-cells = <3>;
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&intc>;
-				fsl,mf-mix-wakeup-irq = <0x7c00000 0x7d00 0x0 0x1400640>;
 			};
 
 			iomuxc: pinctrl at 20e0000 {
-- 
2.7.4
