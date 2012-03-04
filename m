From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun,  4 Mar 2012 13:05:29 +0200
Subject: [PATCH] ARM: OMAP: don't build hwspinlock in vain
Message-ID: <1330859129-354-1-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cleanup: don't build mach-omap2/hwspinlock.c if the OMAP hwspinlock
driver isn't configured.

This will both shorten build time and avoid registering a device
which isn't needed.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
Tony, it's probably better if you take it, to minimize omap merge conflicts.
Thanks!

 arch/arm/mach-omap2/Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 00d7025..5bce3bd 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -268,7 +268,9 @@ obj-y					+= $(smc91x-m) $(smc91x-y)
 
 smsc911x-$(CONFIG_SMSC911X)		:= gpmc-smsc911x.o
 obj-y					+= $(smsc911x-m) $(smsc911x-y)
-obj-$(CONFIG_ARCH_OMAP4)		+= hwspinlock.o
+ifneq ($(CONFIG_HWSPINLOCK_OMAP),)
+obj-y					+= hwspinlock.o
+endif
 
 obj-y					+= common-board-devices.o twl-common.o
 
-- 
1.7.5.4
