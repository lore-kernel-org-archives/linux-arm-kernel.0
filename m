From: jhbird.choi@gmail.com (jhbird.choi at gmail.com)
Date: Sat, 29 Oct 2011 06:45:12 +0900
Subject: [PATCH] ARM: SAMSUNG: Fix compile error due to kfree
Message-ID: <1319838312-8205-1-git-send-email-jhbird.choi@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonghwan Choi <jhbird.choi@gmail.com>

Fix  implicit declaration of function 'kfree'

Signed-off-by: Jonghwan Choi <jhbird.choi@gmail.com>
---
 arch/arm/plat-samsung/dev-backlight.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-backlight.c b/arch/arm/plat-samsung/dev-backlight.c
index 3cedd4c..2adbeae 100644
--- a/arch/arm/plat-samsung/dev-backlight.c
+++ b/arch/arm/plat-samsung/dev-backlight.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/pwm_backlight.h>
+#include <linux/slab.h>
 
 #include <plat/devs.h>
 #include <plat/gpio-cfg.h>
-- 
1.7.0.4
