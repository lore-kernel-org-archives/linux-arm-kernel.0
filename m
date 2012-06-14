From: stigge@antcom.de (Roland Stigge)
Date: Thu, 14 Jun 2012 18:50:55 +0200
Subject: [PATCH v2 05/23] ARM: LPC32xx: Adjust dtsi file for MLC controller
 configuration
In-Reply-To: <1339692673-7848-1-git-send-email-stigge@antcom.de>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
Message-ID: <1339692673-7848-6-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch takes into account that the MTD NAND MLC controller needs more
registers, located actually before the previously allocated memory range,
already starting at 200a8000 instead of 200b0000.

Further, the interrupt for the controller is configured.

Signed-off-by: Roland Stigge <stigge@antcom.de>
Tested-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

---
 arch/arm/boot/dts/lpc32xx.dtsi |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.orig/arch/arm/boot/dts/lpc32xx.dtsi
+++ linux-2.6/arch/arm/boot/dts/lpc32xx.dtsi
@@ -38,9 +38,10 @@
 			status = "disable";
 		};
 
-		mlc: flash at 200B0000 {
+		mlc: flash at 200a8000 {
 			compatible = "nxp,lpc3220-mlc";
-			reg = <0x200B0000 0x1000>;
+			reg = <0x200a8000 0x11000>;
+			interrupts = <11 0>;
 			status = "disable";
 		};
 
