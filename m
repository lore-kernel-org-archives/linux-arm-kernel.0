From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 18 Dec 2017 11:27:13 +0100
Subject: [PATCH] ARM64: dts: meson-gxl: add internal ethernet PHY irq
Message-ID: <20171218102713.4506-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the interrupt of the internal ethernet PHY

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Hi Kevin,

This changes depends on the net-next changes adding interrupt support [0].
It is really important that this change is not merged before its
dependency.

If it is merged before, instead of polling, the phy would wait for an
interrupt which has not been configured and will never fire.

Tested on the libretech-cc and khadas VIM.

Cheers
Jerome

https://lkml.kernel.org/r/20171218094446.31912-7-jbrunet at baylibre.com

 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 4a316a11a00e..8bc404508a4f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -631,6 +631,7 @@
 
 			internal_phy: ethernet-phy at 8 {
 				compatible = "ethernet-phy-id0181.4400", "ethernet-phy-ieee802.3-c22";
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <8>;
 				max-speed = <100>;
 			};
-- 
2.14.3
