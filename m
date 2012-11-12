From: Frank.Li@freescale.com (Frank Li)
Date: Mon, 12 Nov 2012 17:58:28 +0800
Subject: [PATCH 1/2] regulator: gpio-regulator: doc: Fix wrong key gpio-enable
Message-ID: <1352714308-27007-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wrong description in binding document.
Doc use "gpio-enable", but code use "enable-gpio"

In drivers/regulator/gpio-regulator.c
	config->enable_gpio = of_get_named_gpio(np, "enable-gpio", 0);

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 .../bindings/regulator/gpio-regulator.txt          |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
index 3703be2..f71f808 100644
--- a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
@@ -4,7 +4,7 @@ Required properties:
 - compatible		: Must be "regulator-gpio".
 
 Optional properties:
-- gpio-enable		: GPIO to use to enable/disable the regulator.
+- enable-gpio		: GPIO to use to enable/disable the regulator.
 - gpios			: GPIO group used to control voltage.
 - states		: Selection of available voltages and GPIO configs.
 - startup-delay-us	: Startup time in microseconds.
@@ -23,7 +23,7 @@ Example:
 		regulator-max-microvolt = <2600000>;
 		regulator-boot-on;
 
-		gpio-enable = <&gpio0 23 0x4>;
+		enable-gpio = <&gpio0 23 0x4>;
 		gpios = <&gpio0 24 0x4
 			 &gpio0 25 0x4>;
 		states = <1800000 0x3
-- 
1.7.1
