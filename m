From: axel.lin@ingics.com (Axel Lin)
Date: Sun, 04 Nov 2012 23:30:42 +0800
Subject: [PATCH] pinctrl: nomadik: Add terminating entry for
 platform_device_id table
Message-ID: <1352043042.11324.0.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id table is supposed to be zero-terminated.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pinctrl/pinctrl-nomadik.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index f2fd99b..22f6937 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -1922,6 +1922,7 @@ static const struct platform_device_id nmk_pinctrl_id[] = {
 	{ "pinctrl-stn8815", PINCTRL_NMK_STN8815 },
 	{ "pinctrl-db8500", PINCTRL_NMK_DB8500 },
 	{ "pinctrl-db8540", PINCTRL_NMK_DB8540 },
+	{ }
 };
 
 static struct platform_driver nmk_pinctrl_driver = {
-- 
1.7.9.5
