From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 21 Apr 2012 13:11:22 +0400
Subject: [PATCH 09/17] ARM clps711x: Using a single definition for physical
 address register
In-Reply-To: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
Message-ID: <1334999490-27177-10-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using a single definition for the physical address register for all
variants boards clps711x.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/include/asm/hardware/ep7211.h         |    2 --
 arch/arm/include/asm/hardware/ep7212.h         |    2 --
 arch/arm/mach-clps711x/include/mach/hardware.h |    4 ----
 3 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/hardware/ep7211.h b/arch/arm/include/asm/hardware/ep7211.h
index 0b09e38..4b3f86b 100644
--- a/arch/arm/include/asm/hardware/ep7211.h
+++ b/arch/arm/include/asm/hardware/ep7211.h
@@ -23,8 +23,6 @@
 #ifndef __ASM_HARDWARE_EP7211_H
 #define __ASM_HARDWARE_EP7211_H
 
-#define EP7211_PHYS_BASE	(0x80000000)
-
 /*
  * XXX miket at bluemug.com: need to introduce EP7211 registers (those not
  * present in 7212) here.
diff --git a/arch/arm/include/asm/hardware/ep7212.h b/arch/arm/include/asm/hardware/ep7212.h
index 2672291..aad07f7 100644
--- a/arch/arm/include/asm/hardware/ep7212.h
+++ b/arch/arm/include/asm/hardware/ep7212.h
@@ -23,8 +23,6 @@
 #ifndef __ASM_HARDWARE_EP7212_H
 #define __ASM_HARDWARE_EP7212_H
 
-#define EP7212_PHYS_BASE	(0x80000000)
-
 /*
  * These registers are specific to the EP7212 only
  */
diff --git a/arch/arm/mach-clps711x/include/mach/hardware.h b/arch/arm/mach-clps711x/include/mach/hardware.h
index fa9b8f2..50d68c2 100644
--- a/arch/arm/mach-clps711x/include/mach/hardware.h
+++ b/arch/arm/mach-clps711x/include/mach/hardware.h
@@ -73,10 +73,6 @@
 #if defined (CONFIG_ARCH_CDB89712)
 
 /* static cdb89712_map_io() areas */
-#define REGISTER_START   0x80000000
-#define REGISTER_SIZE    0x4000
-#define REGISTER_BASE    0xff000000
-
 #define ETHER_START      0x20000000
 #define ETHER_SIZE       0x1000
 #define ETHER_BASE       0xfe000000
-- 
1.7.3.4
