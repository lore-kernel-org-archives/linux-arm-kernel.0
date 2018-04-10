From: tuomas@tuxera.com (Tuomas Tynkkynen)
Date: Tue, 10 Apr 2018 17:51:19 +0300
Subject: [PATCH] ARM: dts: sunxi: Change sun7i-a20-olimex-som204-evb to not
 use cd-inverted
Message-ID: <20180410145119.27362-1-tuomas@tuxera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 45e01f401a2a16 ("ARM: dts: sunxi: Switch MMC nodes away from
cd-inverted property") changed most of the sunxi boards away from using
the cd-inverted property in MMC nodes. However, the
sun7i-a20-olimex-som204-evb board which got merged concurrently with
that commit is now using cd-inverted. Switch it away from using
cd-inverted to be consistent with rest of the sunxi boards.

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
---
 arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
index eae8e267b9ef..3d7b5c848fef 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
@@ -172,8 +172,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
2.16.3
