From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 21 Nov 2012 15:56:42 +0100
Subject: [PATCH 4/4] ARM: at91: pm9g45: add mmc support
In-Reply-To: <1353509802-20445-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121121145552.GW4398@game.jcrosoft.org>
 <1353509802-20445-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1353509802-20445-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/pm9g45.dts |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/pm9g45.dts b/arch/arm/boot/dts/pm9g45.dts
index b0c258d..387fedb 100644
--- a/arch/arm/boot/dts/pm9g45.dts
+++ b/arch/arm/boot/dts/pm9g45.dts
@@ -46,12 +46,33 @@
 							 2 14 0x0 0x1>;	/* PC14 gpio enable pin pull_up */
 					};
 				};
+
+				mmc {
+					pinctrl_board_mmc: mmc0-board {
+						atmel,pins =
+							<3 6 0x0 0x5>;	/* PD6 gpio CD pin pull_up and deglitch */
+					};
+				};
+			};
+
+			mmc0: mmc at fff80000 {
+				pinctrl-0 = <
+					&pinctrl_board_mmc
+					&pinctrl_mmc0_slot0_clk_cmd_dat0
+					&pinctrl_mmc0_slot0_dat1_3>;
+				status = "okay";
+				slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+					cd-gpios = <&pioD 6 0>;
+				};
 			};
 
 			macb0: ethernet at fffbc000 {
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.10.4
