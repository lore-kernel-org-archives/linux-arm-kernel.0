From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 18 May 2016 18:36:28 -0500
Subject: [PATCH 3/8] ARM: dts: am335x-boneblack: Enable 1GHz OPP for cpu
In-Reply-To: <cover.1463606963.git.d-gerlach@ti.com>
References: <cover.1463606963.git.d-gerlach@ti.com>
Message-ID: <f093008d2e4c0754c1790a606b3568b892d054ee.1463606963.git.d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although all PG2.0 silicon may not support 1GHz OPP for the MPU, older
Beaglebone Blacks may have PG2.0 silicon populated and these particular
parts are guaranteed to support the OPP, so enable it for PG2.0 on
am335x-boneblack only.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am335x-boneblack.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 55c0e954b146..ca721670bd91 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -33,6 +33,17 @@
 	status = "okay";
 };
 
+&cpu0_opp_table {
+	/*
+	 * All PG 2.0 silicon may not support 1GHz but some of the early
+	 * BeagleBone Blacks have PG 2.0 silicon which is guaranteed
+	 * to support 1GHz OPP so enable it for PG 2.0 on this board.
+	 */
+	oppnitro at 1000000000 {
+		opp-supported-hw = <0x06 0x0100>;
+	};
+};
+
 &am33xx_pinmux {
 	nxp_hdmi_bonelt_pins: nxp_hdmi_bonelt_pins {
 		pinctrl-single,pins = <
-- 
2.7.3
