From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  4 Jan 2012 11:21:43 +0100
Subject: [PATCH 1/2] mach-sa1100: fix sched_clock breakage
Message-ID: <1325672503-16690-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed up a simple typo in the runtime sched_clock conversion
so we compile again.

Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-sa1100/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index 1ee6d4c..69e3353 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -19,7 +19,7 @@
 #include <asm/sched_clock.h>
 #include <mach/hardware.h>
 
-static u32 notrace sa100_read_sched_clock(void)
+static u32 notrace sa1100_read_sched_clock(void)
 {
 	return OSCR;
 }
-- 
1.7.6.4
