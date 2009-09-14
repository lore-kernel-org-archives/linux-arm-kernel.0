From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 14 Sep 2009 13:23:50 +0200
Subject: [PATCH] Include device.h in VIC driver
Message-ID: <1252927430-23866-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently build with the next head fails on archs using PL190
VIC because when we include amba/bus.h we need to include
device.h first.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/common/vic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index 920ced0..f232941 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -22,6 +22,7 @@
 #include <linux/list.h>
 #include <linux/io.h>
 #include <linux/sysdev.h>
+#include <linux/device.h>
 #include <linux/amba/bus.h>
 
 #include <asm/mach/irq.h>
-- 
1.6.2.1
