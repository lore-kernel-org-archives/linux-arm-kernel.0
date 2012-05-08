From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Wed, 9 May 2012 01:22:01 +0530
Subject: [PATCH-V2 1/4] ARM: OMAP2+: CLEANUP: All OMAP2PLUS uses omap-device.o
 target so add one entry
In-Reply-To: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
References: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
Message-ID: <1336506724-5494-2-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All OMAP2PLUS based devices, builds omap-device.o target;
so just add one entry so that there is no need to patch this file
for any future OMAP2+ devices.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/Makefile |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index ed8605f..c5b5f05 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -10,9 +10,7 @@ obj-n :=
 obj-  :=

 # omap_device support (OMAP2+ only at the moment)
-obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
-obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
-obj-$(CONFIG_ARCH_OMAP4) += omap_device.o
+obj-$(CONFIG_ARCH_OMAP2PLUS) += omap_device.o

 obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
 obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
--
1.7.0.4
