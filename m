From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 26 Jul 2018 12:48:05 +0800
Subject: [PATCH] arm64: allwinner: dts: h6: fix Pine H64 MMC bus width
Message-ID: <20180726044805.55888-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the enabled MMC controllers on Pine H64 do not have bus-width
set, which make them fall back to 1-bit mode and become quite slow.

Fix this by add the corresponding bus-width properties.

Fixes: ecbd611882a1 ("arm64: allwinner: h6: enable MMC0/2 on Pine H64")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index ceffc40810ee..48daec7f78ba 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -46,6 +46,7 @@
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
 	status = "okay";
 };
 
@@ -56,6 +57,7 @@
 	vqmmc-supply = <&reg_bldo2>;
 	non-removable;
 	cap-mmc-hw-reset;
+	bus-width = <8>;
 	status = "okay";
 };
 
-- 
2.18.0
