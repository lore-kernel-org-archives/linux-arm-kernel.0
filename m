From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 18 Jan 2017 14:20:01 +0100
Subject: [PATCH v3 13/13] ARM: dts: da850-lcdk: enable the SATA node
In-Reply-To: <1484745601-4769-1-git-send-email-bgolaszewski@baylibre.com>
References: <1484745601-4769-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1484745601-4769-14-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the SATA node for da850-lcdk. We omit the pinctrl property on
purpose - the muxed SATA pins are not hooked up to anything
SATA-related on the lcdk.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index afcb482..fbeee3c 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -105,6 +105,10 @@
 	status = "okay";
 };
 
+&sata {
+	status = "okay";
+};
+
 &mdio {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mdio_pins>;
-- 
2.9.3
