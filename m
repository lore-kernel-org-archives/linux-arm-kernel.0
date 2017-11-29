From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Nov 2017 16:54:44 -0200
Subject: [PATCH v2 11/11] ARM: dts: vf500: Fix interrupt-controller unit
 address
In-Reply-To: <1511981684-13433-1-git-send-email-festevam@gmail.com>
References: <1511981684-13433-1-git-send-email-festevam@gmail.com>
Message-ID: <1511981684-13433-11-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The correct unit address for interrupt-controller is 0x40003000, so
change it accordingly in order to fix the following build warning
with W=1:

arch/arm/boot/dts/vf500-colibri-eval-v3.dtb: Warning (simple_bus_reg): Node /soc/aips-bus at 40000000/interrupt-controller at 40002000 simple-bus unit address format error, expected "40003000"

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- None

 arch/arm/boot/dts/vf500.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf500.dtsi b/arch/arm/boot/dts/vf500.dtsi
index 3d98961..348bcd3 100644
--- a/arch/arm/boot/dts/vf500.dtsi
+++ b/arch/arm/boot/dts/vf500.dtsi
@@ -58,7 +58,7 @@
 	soc {
 		aips-bus at 40000000 {
 
-			intc: interrupt-controller at 40002000 {
+			intc: interrupt-controller at 40003000 {
 				compatible = "arm,cortex-a9-gic";
 				#interrupt-cells = <3>;
 				interrupt-controller;
-- 
2.7.4
