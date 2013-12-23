From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 23 Dec 2013 09:48:09 +0100
Subject: [PATCH 1/3] ARM: mvebu: move ARMADA_XP_MAX_CPUS to armada-370-xp.h
In-Reply-To: <1387788491-3168-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1387788491-3168-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1387788491-3168-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARMADA_XP_MAX_CPUS definition was in common.h, which as its name
says, is common to all mvebu SoCs. It is more logical to have this XP
specific definition in the already existing armada-370-xp.h header
file, especially in preparation to the addition of the support for
other SOCs in mach-mvebu.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.h | 2 ++
 arch/arm/mach-mvebu/common.h        | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
index c612b2c..4ed534d 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.h
+++ b/arch/arm/mach-mvebu/armada-370-xp.h
@@ -18,6 +18,8 @@
 #ifdef CONFIG_SMP
 #include <linux/cpumask.h>
 
+#define ARMADA_XP_MAX_CPUS 4
+
 void armada_mpic_send_doorbell(const struct cpumask *mask, unsigned int irq);
 void armada_xp_mpic_smp_cpu_init(void);
 #endif
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index e366010..f7ad45e 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -15,8 +15,6 @@
 #ifndef __ARCH_MVEBU_COMMON_H
 #define __ARCH_MVEBU_COMMON_H
 
-#define ARMADA_XP_MAX_CPUS 4
-
 #include <linux/reboot.h>
 
 void mvebu_restart(enum reboot_mode mode, const char *cmd);
-- 
1.8.3.2
