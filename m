From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 23 Nov 2012 19:45:31 +0100
Subject: [PATCH 2/3] ARM: at91: dt: sam9m10g45ek add spi support
In-Reply-To: <1353696332-12741-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121123184115.GB4398@game.jcrosoft.org>
 <1353696332-12741-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1353696332-12741-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9m10g45ek.dts |   33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 20c3191..829cbb1 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -102,6 +102,39 @@
 					};
 				};
 			};
+
+			spi0: spi at fffa4000 {
+				cs-gpios = <&pioB 3 0>;
+				status = "okay";
+
+				flash: at45db321d at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "atmel,at45db321d", "atmel,at45", "atmel,dataflash";
+					reg = <0>;
+					spi-max-frequency = <15000000>;
+
+					bootstrap at 0 {
+						label = "bootstrap";
+						reg = <0x0 0x7fe0>;
+					};
+
+					barebox at 7fe0 {
+						label = "barebox";
+						reg = <0x7fe0 0x40110>;
+					};
+
+					bareboxenv at 480f0 {
+						label = "bareboxenv";
+						reg = <0x480f0 0x7fe0>;
+					};
+
+					kernel at 500d0 {
+						label = "Kernel";
+						reg = <0x500d0 0x3cff30>;
+					};
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.10.4
