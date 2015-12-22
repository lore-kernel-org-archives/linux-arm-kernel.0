From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 22 Dec 2015 17:08:06 +0800
Subject: [PATCH] regulator: axp20x: Fix GPIO LDO enable value for AXP22x
Message-ID: <1450775286-25223-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable/disable values for GPIO LDOs are reversed. It seems no one
noticed as AXP22x support was introduced recently, and no one was using
the GPIO LDOs, either because no designs actually use them or board
support hasn't caught up.

Fixes: 1b82b4e4f954 ("regulator: axp20x: Add support for AXP22X regulators")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This was discovered while working on the newer AXP809, which uses the same
register layout and values. I then double checked the AXP22X datasheets.

---
 drivers/regulator/axp20x-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 35de22fdb7a0..f2e1a39ce0f3 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -27,8 +27,8 @@
 #define AXP20X_IO_ENABLED		0x03
 #define AXP20X_IO_DISABLED		0x07
 
-#define AXP22X_IO_ENABLED		0x04
-#define AXP22X_IO_DISABLED		0x03
+#define AXP22X_IO_ENABLED		0x03
+#define AXP22X_IO_DISABLED		0x04
 
 #define AXP20X_WORKMODE_DCDC2_MASK	BIT(2)
 #define AXP20X_WORKMODE_DCDC3_MASK	BIT(1)
-- 
2.6.4
