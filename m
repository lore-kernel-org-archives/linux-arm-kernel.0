From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 18 Sep 2016 12:28:52 +0200
Subject: [PATCH] ARM: tegra: nyan: Mark all USB ports as host
Message-ID: <20160918102852.6593-1-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nyan boards only have host USB ports (2 external, 1 internal), there is
no OTG-enabled connector.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 18db797..254b2ee 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -435,7 +435,7 @@
 			usb2-0 {
 				vbus-supply = <&vdd_usb1_vbus>;
 				status = "okay";
-				mode = "otg";
+				mode = "host";
 			};
 
 			usb2-1 {
-- 
2.9.3
