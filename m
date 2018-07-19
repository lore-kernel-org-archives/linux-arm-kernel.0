From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 19 Jul 2018 18:00:42 +0200
Subject: [RFT 02/10] pinctrl: samsung: Document suspend and resume members
In-Reply-To: <20180719160050.22566-1-krzk@kernel.org>
References: <20180719160050.22566-1-krzk@kernel.org>
Message-ID: <20180719160050.22566-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing documentation for suspend and resume members of struct
samsung_pin_ctrl and samsung_pinctrl_drv_data.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pinctrl/samsung/pinctrl-samsung.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index f0cda9424dfe..aac16cc8362a 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -223,6 +223,10 @@ struct samsung_retention_data {
  *	interrupts for the controller.
  * @eint_wkup_init: platform specific callback to setup the external wakeup
  *	interrupts for the controller.
+ * @suspend: platform specific suspend callback, executed during pin controller
+ *	device suspend, see samsung_pinctrl_suspend()
+ * @resume: platform specific resume callback, executed during pin controller
+ *	device suspend, see samsung_pinctrl_resume()
  */
 struct samsung_pin_ctrl {
 	const struct samsung_pin_bank_data *pin_banks;
@@ -255,6 +259,10 @@ struct samsung_pin_ctrl {
  * @pin_base: starting system wide pin number.
  * @nr_pins: number of pins supported by the controller.
  * @retention_ctrl: retention control runtime data.
+ * @suspend: platform specific suspend callback, executed during pin controller
+ *	device suspend, see samsung_pinctrl_suspend()
+ * @resume: platform specific resume callback, executed during pin controller
+ *	device suspend, see samsung_pinctrl_resume()
  */
 struct samsung_pinctrl_drv_data {
 	struct list_head		node;
-- 
2.14.1
