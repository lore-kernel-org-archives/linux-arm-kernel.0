From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 21 Apr 2012 12:28:25 +0200
Subject: [PATCH] arm: at91: fix build-error for board-dt
Message-ID: <1335004105-3162-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wolfram@the-dreams.de>

When build-testing i2c-patches, I encountered:

arch/arm/mach-at91/built-in.o:(.arch.info.init+0x34): undefined reference to `at91sam926x_timer'

(using allnoconfig and roughly only MACH_AT91SAM_DT enabled)

Since this boardfile doesn't belong to a specific architecture, directly
add the only supported timer to compilation.

Signed-off-by: Wolfram Sang <wolfram@the-dreams.de>
---
 arch/arm/mach-at91/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 8512e53..d7c17fc 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -79,7 +79,7 @@ obj-$(CONFIG_MACH_SNAPPER_9260)	+= board-snapper9260.o
 obj-$(CONFIG_MACH_AT91SAM9M10G45EK) += board-sam9m10g45ek.o
 
 # AT91SAM board with device-tree
-obj-$(CONFIG_MACH_AT91SAM_DT) += board-dt.o
+obj-$(CONFIG_MACH_AT91SAM_DT) += board-dt.o at91sam926x_time.o
 
 # AT91X40 board-specific support
 obj-$(CONFIG_MACH_AT91EB01)	+= board-eb01.o
-- 
1.7.10
