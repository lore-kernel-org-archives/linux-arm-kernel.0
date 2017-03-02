From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Thu, 2 Mar 2017 17:28:45 +0200
Subject: [PATCH v2 2/2] drivers: pwm: pwm-atmel: enable PWM on sama5d2
In-Reply-To: <1488468525-28726-1-git-send-email-claudiu.beznea@microchip.com>
References: <1488468525-28726-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1488468525-28726-3-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sama5d2 can use the same atmel_pwm_data as sama5d3.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

---
 Documentation/devicetree/bindings/pwm/atmel-pwm.txt | 1 +
 drivers/pwm/pwm-atmel.c                             | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
index 02331b9..c8c831d 100644
--- a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
@@ -4,6 +4,7 @@ Required properties:
   - compatible: should be one of:
     - "atmel,at91sam9rl-pwm"
     - "atmel,sama5d3-pwm"
+    - "atmel,sama5d2-pwm"
   - reg: physical base address and length of the controller's registers
   - #pwm-cells: Should be 3. See pwm.txt in this directory for a
     description of the cells format.
diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 3db82c3..e773311 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -332,6 +332,9 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
 		.compatible = "atmel,sama5d3-pwm",
 		.data = &atmel_pwm_data_v2,
 	}, {
+		.compatible = "atmel,sama5d2-pwm",
+		.data = &atmel_pwm_data_v2,
+	}, {
 		/* sentinel */
 	},
 };
-- 
2.7.4
