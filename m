From: nm@ti.com (Nishanth Menon)
Date: Wed, 17 Jul 2013 11:45:36 -0500
Subject: [PATCH 7/9] ARM: dts: omap5-uevm: update LDO6 voltage to 1.2V
In-Reply-To: <1374079538-19548-1-git-send-email-nm@ti.com>
References: <1374079538-19548-1-git-send-email-nm@ti.com>
Message-ID: <1374079538-19548-8-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit e00c27ef3b4c23e39d0a77b7c8e5be44c28001c7
(ARM: dts: OMAP5: Add Palmas MFD node and regulator nodes)
introduced regulator entries for OMAP5uEVM.

However, The regulator information is based on an older temporary
pre-production board variant and does not reflect production board
750-2628-XXX boards.

LDO6 supplies the board specified VDDS_1V2_WKUP supply going to
ldo_emu_wkup/vdds_hsic. To stay within the SoC specification supply
1.2V instead of 1.5V.

Reported-by: Marc J?ttner <m-juettner@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 1550d6a..3ff5874 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -388,8 +388,8 @@
 				ldo6_reg: ldo6 {
 					/* VDDS_1V2_WKUP: hsic/ldo_emu_wkup */
 					regulator-name = "ldo6";
-					regulator-min-microvolt = <1500000>;
-					regulator-max-microvolt = <1500000>;
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
 					regulator-always-on;
 					regulator-boot-on;
 				};
-- 
1.7.9.5
