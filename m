From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 13 Jan 2017 13:38:04 +0100
Subject: [PATCH 10/10] ARM: dts: da850-lcdk: enable the SATA node
In-Reply-To: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1484311084-31547-11-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the SATA node for da850-lcdk. We omit the pinctrl property on
purpose - the muxed SATA pins are not hooked up to anything
SATA-related on the lcdk.

The REFCLKN/P rate on the board is 100MHz, so we need a multiplier of
15 for 1.5GHz PLL rate.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index afcb482..1e638da 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -105,6 +105,11 @@
 	status = "okay";
 };
 
+&sata {
+	status = "okay";
+	da850,clk_multiplier = <15>;
+};
+
 &mdio {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mdio_pins>;
-- 
2.9.3
