From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  7 Nov 2018 11:45:50 +0100
Subject: [PATCH 4/4] arm64: dts: meson-gxl-khadas-vim: fix GPIO lines names
In-Reply-To: <1541587550-17842-1-git-send-email-narmstrong@baylibre.com>
References: <1541587550-17842-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1541587550-17842-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio line names were set in the pinctrl node instead of the gpio node,
at the time it was merged, it worked, but was obviously wrong.
This patch moves the properties to the gpio nodes.

Fixes: 60795933b709 ("ARM64: dts: meson-gxl-khadas-vim: Add GPIO lines names")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index d32cf38..864ef01 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -112,7 +112,7 @@
 	linux,rc-map-name = "rc-geekbox";
 };
 
-&pinctrl_aobus {
+&gpio_ao {
 	gpio-line-names = "UART TX",
 			  "UART RX",
 			  "Power Key In",
@@ -127,7 +127,7 @@
 			  "";
 };
 
-&pinctrl_periphs {
+&gpio {
 	gpio-line-names = /* Bank GPIOZ */
 			  "", "", "", "", "", "", "",
 			  "", "", "", "", "", "", "",
-- 
2.7.4
