From: axel.lin@ingics.com (Axel Lin)
Date: Tue, 20 Aug 2013 13:58:00 +0800
Subject: [PATCH] pinctrl: SPEAr310: Pass correct of_device_id table name to
 MODULE_DEVICE_TABLE
Message-ID: <1376978280.19775.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The symbol SPEAr310_pinctrl_of_match does not exist at all. Fix it.
We didn't hit the compile error because this driver can only be built-in now.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pinctrl/spear/pinctrl-spear310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/spear/pinctrl-spear310.c b/drivers/pinctrl/spear/pinctrl-spear310.c
index 06c7e6f..ed1d360 100644
--- a/drivers/pinctrl/spear/pinctrl-spear310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear310.c
@@ -430,4 +430,4 @@ module_exit(spear310_pinctrl_exit);
 MODULE_AUTHOR("Viresh Kumar <viresh.linux@gmail.com>");
 MODULE_DESCRIPTION("ST Microelectronics SPEAr310 pinctrl driver");
 MODULE_LICENSE("GPL v2");
-MODULE_DEVICE_TABLE(of, SPEAr310_pinctrl_of_match);
+MODULE_DEVICE_TABLE(of, spear310_pinctrl_of_match);
-- 
1.8.1.2
