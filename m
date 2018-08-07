From: tuomas@tuxera.com (Tuomas Tynkkynen)
Date: Wed, 8 Aug 2018 02:25:54 +0300
Subject: [PATCH 2/2] arm64: dts: sunxi: Don't use cd-inverted in
 sun50i-a64-pinebook
In-Reply-To: <20180807232554.16825-1-tuomas@tuxera.com>
References: <20180807232554.16825-1-tuomas@tuxera.com>
Message-ID: <20180807232554.16825-2-tuomas@tuxera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another user of cd-inverted seems to have crept in. Switch it away from
cd-inverted to be consistent with other sunxi boards.

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 897e60cbe38d..4b8fe453bacd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -80,8 +80,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	bus-width = <4>;
 	status = "okay";
-- 
2.16.3
