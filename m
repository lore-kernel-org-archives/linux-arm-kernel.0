From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 29 Mar 2017 15:35:37 +0200
Subject: [PATCH] ARM: dts: imx6: ZII-RDU2: fix FEC node properties
Message-ID: <20170329133537.26028-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These have been messed up during mainlining of the DT files.
Fix them to be valid properties.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
Shawn, if possible, it would be nice to squash this fix into the
broken patch adding those DT files, but that's up to you.
8b44da415afc (ARM: dts: imx6: add ZII RDU2 boards)
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index bcff7876b1df..5d94b5ee6aa0 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -615,8 +615,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio1 23 0 GPIO_ACTIVE_LOW>;
-	phy-reset-duration = "100";
+	phy-reset-gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <100>;
 	phy-supply = <&reg_3p3v>;
 	status = "okay";
 
-- 
2.11.0
