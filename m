From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 Apr 2018 16:50:31 -0300
Subject: [PATCH 3/5] ARM: dts: imx6q-b850v3: Remove #address/#size-cells from
 stdp2690
In-Reply-To: <1524513033-21136-1-git-send-email-festevam@gmail.com>
References: <1524513033-21136-1-git-send-email-festevam@gmail.com>
Message-ID: <1524513033-21136-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove unnecessary #address-cells/#size-cells to fix the following
DTC warnings:

arch/arm/boot/dts/imx6q-b850v3.dtb: Warning (avoid_unnecessary_addr_size): /soc/aips-bus at 2100000/i2c at 21a4000/mux at 70/i2c at 1/stdp2690 at 72: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
arch/arm/boot/dts/imx6q-b850v3.dtb: Warning (avoid_unnecessary_addr_size): /soc/aips-bus at 2100000/i2c at 21a4000/mux at 70/i2c at 1/stdp4028 at 73: unnecessary #address-cells/#size-cells without "ranges" or child
"reg" property

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6q-b850v3.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
index 35edbdc..044a5be 100644
--- a/arch/arm/boot/dts/imx6q-b850v3.dts
+++ b/arch/arm/boot/dts/imx6q-b850v3.dts
@@ -156,8 +156,6 @@
 
 	stdp2690 at 72 {
 		compatible = "megachips,stdp2690-ge-b850v3-fw";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <0x72>;
 
 		ports {
@@ -184,8 +182,6 @@
 
 	stdp4028 at 73 {
 		compatible = "megachips,stdp4028-ge-b850v3-fw";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <0x73>;
 		interrupt-parent = <&gpio2>;
 		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.7.4
