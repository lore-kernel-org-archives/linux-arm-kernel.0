From: nm@ti.com (Nishanth Menon)
Date: Wed, 17 Jul 2013 11:45:35 -0500
Subject: [PATCH 6/9] ARM: dts: omap5-uevm: update LDO4 voltage to 1.5V and
 settings
In-Reply-To: <1374079538-19548-1-git-send-email-nm@ti.com>
References: <1374079538-19548-1-git-send-email-nm@ti.com>
Message-ID: <1374079538-19548-7-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit e00c27ef3b4c23e39d0a77b7c8e5be44c28001c7
(ARM: dts: OMAP5: Add Palmas MFD node and regulator nodes)
introduced regulator entries for OMAP5uEVM.

However, The regulator information is based on an older temporary
pre-production board variant and does not reflect production board
750-2628-XXX boards.

LDO4 supplies VDDAPHY_DISP which is vdda_dsiporta/c/vdda_hdmi

This can only be supplied at 1.5V or 1.8V and we currently
supply 2.2V.

To prevent any potential device damage risk, use the specified
1.5V-1.8V supply.

Remove 'always-on' and 'boot-on' settings here as it is a 'on need'
supply to SoC IP and is not enabled by PMIC by default at boot.

Reported-by: Marc J?ttner <m-juettner@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index c6d560b..1550d6a 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -372,10 +372,8 @@
 				ldo4_reg: ldo4 {
 					/* VDDAPHY_DISP: vdda_dsiport/hdmi */
 					regulator-name = "ldo4";
-					regulator-min-microvolt = <2200000>;
-					regulator-max-microvolt = <2200000>;
-					regulator-always-on;
-					regulator-boot-on;
+					regulator-min-microvolt = <1500000>;
+					regulator-max-microvolt = <1800000>;
 				};
 
 				ldo5_reg: ldo5 {
-- 
1.7.9.5
