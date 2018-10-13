From: christianshewitt@gmail.com (Christian Hewitt)
Date: Sat, 13 Oct 2018 16:07:06 +0400
Subject: [PATCH] ARM64: dts: meson-gxl-s905x-khadas-vim enable Bluetooth
Message-ID: <1539432427-11779-1-git-send-email-christianshewitt@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables Bluetooth support for the following models:

- Khadas VIM basic (AP6212) using firmware BCM43438A1.hcd
- Khadas VIM pro (AP6255) using firmware BCM4345C0.hcd

The AP6212 module used on the VIM basic has an ID clash with another
device. To get Bluetooth working you either need to apply a kernel
patch to drivers/bluetooth/btbcm.c so 0x2209 loads BCM43438A1 or the
BCM43438A1.hcd firmware must be renamed to BCM43430A1.hcd.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index d32cf38..7e0717d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -187,6 +187,13 @@
 	};
 };
 
+&uart_A {
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 /* This is brought out on the Linux_RX (18) and Linux_TX (19) pins: */
 &uart_AO {
 	status = "okay";
-- 
2.7.4
