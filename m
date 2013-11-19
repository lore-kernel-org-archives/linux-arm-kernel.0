From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 19 Nov 2013 18:15:51 +0100
Subject: [PATCH] pinctrl: samsung: Allow pin value to be initialized using
 pinfunc.
Message-ID: <1384881351-10782-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends the range of settings configurable via pinfunc API
to cover pin value as well. This allows configuration of default values
of pins.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 1 +
 drivers/pinctrl/pinctrl-samsung.c                             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index fe34cbb..ed4cc9c 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -74,6 +74,7 @@ Required Properties:
   "samsung,pins" property of the child node. The following pin configuration
   properties are supported.
 
+  - samsung,pin-val: Initial value of pin output buffer.
   - samsung,pin-pud: Pull up/down configuration.
   - samsung,pin-drv: Drive strength configuration.
   - samsung,pin-pud-pdn: Pull up/down configuration in power down mode.
diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index c752de4..6b2194a 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -47,6 +47,7 @@ static struct pin_config {
 	{ "samsung,pin-drv", PINCFG_TYPE_DRV },
 	{ "samsung,pin-con-pdn", PINCFG_TYPE_CON_PDN },
 	{ "samsung,pin-pud-pdn", PINCFG_TYPE_PUD_PDN },
+	{ "samsung,pin-val", PINCFG_TYPE_DAT },
 };
 
 /* Global list of devices (struct samsung_pinctrl_drv_data) */
-- 
1.8.4.2
