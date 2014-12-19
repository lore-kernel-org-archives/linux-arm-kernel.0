From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 19 Dec 2014 18:40:58 +0530
Subject: [PATCH 1/2] pinctrl: exynos: Add AUDIO pin controller for exynos7
In-Reply-To: <1418994659-5222-1-git-send-email-padma.v@samsung.com>
References: <1418994659-5222-1-git-send-email-padma.v@samsung.com>
Message-ID: <1418994659-5222-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Audio IPs on Exynos7 require gpios available in AUDIO
pin controller block. So adding the AUDIO pinctrl support.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 .../bindings/pinctrl/samsung-pinctrl.txt           |    1 +
 drivers/pinctrl/samsung/pinctrl-exynos.c           |   10 ++++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index c88ba35..9d2a995 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -181,6 +181,7 @@ Aliases for controllers compatible with "samsung,exynos7-pinctrl":
 - pinctrl6: pin controller of FSYS0 block,
 - pinctrl7: pin controller of FSYS1 block,
 - pinctrl8: pin controller of BUS1 block,
+- pinctrl9: pin controller of AUDIO block,
 
 Example: A pin-controller node with pin banks:
 
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 2a85cb4..c8f83f9 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -1314,6 +1314,11 @@ static const struct samsung_pin_bank_data exynos7_pin_banks8[] __initconst = {
 	EXYNOS_PIN_BANK_EINTG(3, 0x140, "gpv6", 0x24),
 };
 
+static const struct samsung_pin_bank_data exynos7_pin_banks9[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
+};
+
 const struct samsung_pin_ctrl exynos7_pin_ctrl[] __initconst = {
 	{
 		/* pin-controller instance 0 Alive data */
@@ -1361,5 +1366,10 @@ const struct samsung_pin_ctrl exynos7_pin_ctrl[] __initconst = {
 		.pin_banks	= exynos7_pin_banks8,
 		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks8),
 		.eint_gpio_init = exynos_eint_gpio_init,
+	}, {
+		/* pin-controller instance 9 AUD data */
+		.pin_banks	= exynos7_pin_banks9,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks9),
+		.eint_gpio_init = exynos_eint_gpio_init,
 	},
 };
-- 
1.7.4.4
