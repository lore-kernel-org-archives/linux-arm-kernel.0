From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Mon, 17 Sep 2018 11:28:30 +0800
Subject: [PATCH v3 2/3] dt-bindings: i2c: designware: add optional pinctrl
 for bus recovery
In-Reply-To: <20180917112633.252c591c@xhacker.debian>
References: <20180917112633.252c591c@xhacker.debian>
Message-ID: <20180917112830.2a3c9be9@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the pinctrl property for bus recovery.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/i2c/i2c-designware.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
index 1d6a6a8061ba..c1544d1f7b55 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
@@ -24,6 +24,9 @@ Optional properties :
 
  - sda-gpios: specify the gpio of the SDA line for gpio recovery
 
+ - pinctrl: add extra pinctrl to configure i2c pins to gpio function for i2c
+   bus recovery, call it "gpio" state
+
 Examples :
 
 	i2c at f0000 {
@@ -46,6 +49,9 @@ Examples :
 		i2c-sda-hold-time-ns = <300>;
 		i2c-sda-falling-time-ns = <300>;
 		i2c-scl-falling-time-ns = <300>;
+		pinctrl-names = "default", "gpio";
+		pinctrl-0 = <&pinctrl_i2c1>;
+		pinctrl-1 = <&pinctrl_i2c1_gpio>;
 		scl-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
 		sda-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
 	};
-- 
2.19.0
