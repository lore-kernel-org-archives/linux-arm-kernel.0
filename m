From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 11 May 2013 05:45:56 +1200
Subject: [PATCH] pinctrl: vt8500: Fix incorrect data in WM8750 pinctrl table
Message-ID: <1368207956-32220-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WMT_PIN_WAKEUP1 should be declared as WMT_PIN(0, 17) rather than
WMT_PIN(0, 16). This currently generates a runtime warning because
WMT_PIN_WAKEUP0 is already defined as WMT_PIN(0, 16).

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/pinctrl/vt8500/pinctrl-wm8750.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/vt8500/pinctrl-wm8750.c b/drivers/pinctrl/vt8500/pinctrl-wm8750.c
index b964cc5..de43262 100644
--- a/drivers/pinctrl/vt8500/pinctrl-wm8750.c
+++ b/drivers/pinctrl/vt8500/pinctrl-wm8750.c
@@ -53,7 +53,7 @@ static const struct wmt_pinctrl_bank_registers wm8750_banks[] = {
 #define WMT_PIN_EXTGPIO6	WMT_PIN(0, 6)
 #define WMT_PIN_EXTGPIO7	WMT_PIN(0, 7)
 #define WMT_PIN_WAKEUP0		WMT_PIN(0, 16)
-#define WMT_PIN_WAKEUP1		WMT_PIN(0, 16)
+#define WMT_PIN_WAKEUP1		WMT_PIN(0, 17)
 #define WMT_PIN_SD0CD		WMT_PIN(0, 28)
 #define WMT_PIN_VDOUT0		WMT_PIN(1, 0)
 #define WMT_PIN_VDOUT1		WMT_PIN(1, 1)
-- 
1.7.9.5
