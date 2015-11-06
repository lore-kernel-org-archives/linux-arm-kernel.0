From: tharvey@gateworks.com (Tim Harvey)
Date: Fri,  6 Nov 2015 14:40:30 -0800
Subject: [PATCH 1/3] ARM: dts: imx: ventana: GW54xx PMIC swbst reg always-on
In-Reply-To: <1446849632-20333-1-git-send-email-tharvey@gateworks.com>
References: <1446849632-20333-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1446849632-20333-2-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GW54xx PMIC swbst regulator is used for LVDS power, CANbus xceiver
and HDMI DDC and is enabled by the bootloader. Set the regulator to
always-on so that Linux doesn't turn it off thinking its not needed.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 929e0b3..743db9f 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -260,6 +260,8 @@
 			swbst_reg: swbst {
 				regulator-min-microvolt = <5000000>;
 				regulator-max-microvolt = <5150000>;
+				regulator-boot-on;
+				regulator-always-on;
 			};
 
 			snvs_reg: vsnvs {
-- 
1.9.1
