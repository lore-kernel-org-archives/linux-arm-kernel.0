From: b20788@freescale.com (Anson Huang)
Date: Wed, 5 Aug 2015 01:48:35 +0800
Subject: [PATCH 1/3] ARM: dts: imx6ul: add sram support for i.mx6ul
Message-ID: <1438710517-6515-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SRAM support for i.MX6UL, it has 128KB ocram
starting from 0x900000.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index b6c6c31..227ba6e 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -133,6 +133,11 @@
 			status = "disabled";
 		};
 
+		ocram: sram at 00900000 {
+			compatible = "mmio-sram";
+			reg = <0x00900000 0x20000>;
+		};
+
 		aips1: aips-bus at 02000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
-- 
1.9.1
