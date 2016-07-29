From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri, 29 Jul 2016 09:25:28 +0800
Subject: [PATCH v3 7/7] doc: bindings: act8945a-charger: Update properties
In-Reply-To: <1469755528-8413-1-git-send-email-wenyou.yang@atmel.com>
References: <1469755528-8413-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1469755528-8413-8-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due the driver improvements, update the properties,
 - Remove "active-semi,check-battery-temperature" property.
 - Add the properties, "active-semi,irq_gpio"
   and "active-semi,lbo-gpios".

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/power/act8945a-charger.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/act8945a-charger.txt b/Documentation/devicetree/bindings/power/act8945a-charger.txt
index bea254c..d7cf05b 100644
--- a/Documentation/devicetree/bindings/power/act8945a-charger.txt
+++ b/Documentation/devicetree/bindings/power/act8945a-charger.txt
@@ -4,10 +4,12 @@ Required properties:
  - compatible: "active-semi,act8945a", please refer to ../mfd/act8945a.txt.
  - active-semi,chglev-gpios: charge current level phandle with args
    as described in ../gpio/gpio.txt.
+ - active-semi,irq_gpios: specify the charger interrupt input phanle
+   with args as as described in ../gpio/gpio.txt.
+ - active-semi,lbo-gpios: specify the low battery voltage detect phandle
+   with args as as described in ../gpio/gpio.txt.
 
 Optional properties:
- - active-semi,check-battery-temperature: boolean to check the battery
-   temperature or not.
  - active-semi,input-voltage-threshold-microvolt: unit: mV;
    Specifies the charger's input over-voltage threshold value;
    The value can be: 6600, 7000, 7500, 8000; default: 6600
-- 
2.7.4
