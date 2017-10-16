From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 16 Oct 2017 20:34:02 -0200
Subject: [PATCH 2/4] ARM: dts: imx6sx-softing-vining-2000: Fix the
 'interrupt-parent' property
In-Reply-To: <1508193244-14599-1-git-send-email-festevam@gmail.com>
References: <1508193244-14599-1-git-send-email-festevam@gmail.com>
Message-ID: <1508193244-14599-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The correct property name is 'interrupt-parent', so fix it accordingly.

This fixes the following build warning:

arch/arm/boot/dts/imx6sx-softing-vining-2000.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /soc/aips-bus at 02100000/ethernet at 02188000/mdio/ethernet0-phy at 0
arch/arm/boot/dts/imx6sx-softing-vining-2000.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /soc/aips-bus at 02100000/ethernet at 021b4000/mdio/ethernet1-phy at 0

Cc: Christoph Fritz <chf.fritz@googlemail.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sx-softing-vining-2000.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts b/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
index ee012bc..44bfeac 100644
--- a/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
+++ b/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
@@ -116,7 +116,7 @@
 		ethphy0: ethernet0-phy at 0 {
 			reg = <0>;
 			max-speed = <100>;
-			interrupts-parent = <&gpio2>;
+			interrupt-parent = <&gpio2>;
 			interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
 		};
 	};
@@ -139,7 +139,7 @@
 		ethphy1: ethernet1-phy at 0 {
 			reg = <0>;
 			max-speed = <100>;
-			interrupts-parent = <&gpio2>;
+			interrupt-parent = <&gpio2>;
 			interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
 		};
 	};
-- 
2.7.4
