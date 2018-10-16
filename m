From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 16 Oct 2018 13:50:52 +0300
Subject: [PATCH 1/2] arm64: dts: clearfog-gt-8k: fix USB regulator gpio
 polarity
Message-ID: <d02745d924c2ad65cbd1194fc35d12796613722d.1539687053.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fixed regulator driver ignores the gpio flags, so this change has
no practical effect in the current implementation. Fix it anyway to
correct the hardware description.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index aea9c220ae6a..af1310c53bc8 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -42,7 +42,7 @@
 
 	v_5v0_usb3_hst_vbus: regulator-usb3-vbus0 {
 		compatible = "regulator-fixed";
-		gpio = <&cp0_gpio2 15 GPIO_ACTIVE_HIGH>;
+		gpio = <&cp0_gpio2 15 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&cp0_xhci_vbus_pins>;
 		regulator-name = "v_5v0_usb3_hst_vbus";
-- 
2.19.1
