From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 21 Nov 2012 15:56:41 +0100
Subject: [PATCH 3/4] ARM: at91: Animeo IP: add mmc support
In-Reply-To: <1353509802-20445-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121121145552.GW4398@game.jcrosoft.org>
 <1353509802-20445-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1353509802-20445-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/animeo_ip.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
index 518baed..74d92cd 100644
--- a/arch/arm/boot/dts/animeo_ip.dts
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -66,6 +66,18 @@
 				phy-mode = "mii";
 				status = "okay";
 			};
+
+			mmc0: mmc at fffa8000 {
+				pinctrl-0 = <&pinctrl_mmc0_clk
+					     &pinctrl_mmc0_slot1_cmd_dat0
+					     &pinctrl_mmc0_slot1_dat1_3>;
+				status = "okay";
+
+				slot at 1 {
+					reg = <1>;
+					bus-width = <4>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.10.4
