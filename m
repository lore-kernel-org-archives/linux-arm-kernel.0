From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Mon, 17 Sep 2018 11:27:41 +0800
Subject: [PATCH v3 1/3] dt-bindings: i2c: designware: add optional gpio
 recovery properties
In-Reply-To: <20180917112633.252c591c@xhacker.debian>
References: <20180917112633.252c591c@xhacker.debian>
Message-ID: <20180917112741.7c3d6514@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the scl-gpios and sda-gpios properties for bus recovery.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/i2c/i2c-designware.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
index fbb0a6d8b964..1d6a6a8061ba 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
@@ -20,6 +20,10 @@ Optional properties :
  - i2c-sda-falling-time-ns : should contain the SDA falling time in nanoseconds.
    This value which is by default 300ns is used to compute the tHIGH period.
 
+ - scl-gpios: specify the gpio of the SCL line for gpio recovery
+
+ - sda-gpios: specify the gpio of the SDA line for gpio recovery
+
 Examples :
 
 	i2c at f0000 {
@@ -42,6 +46,8 @@ Examples :
 		i2c-sda-hold-time-ns = <300>;
 		i2c-sda-falling-time-ns = <300>;
 		i2c-scl-falling-time-ns = <300>;
+		scl-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+		sda-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
 	};
 
 	i2c at 1120000 {
-- 
2.19.0
