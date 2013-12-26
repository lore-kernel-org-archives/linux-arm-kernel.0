From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 26 Dec 2013 09:20:26 +0100
Subject: [PATCH 2/2] ARM: mvebu: move Armada 370/XP specific definitions to
 armada-370-xp.h
In-Reply-To: <1388046026-332-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1388046026-332-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1388046026-332-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to the introduction of the support for additional SoC,
the mvebu/common.h should be clear of Armada 370/XP-specific
definitions. Therefore, move the Armada 370/XP SMP specific
definitions to the armada-370-xp.h file.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.h | 2 ++
 arch/arm/mach-mvebu/common.h        | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
index c612b2c..775d9c3 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.h
+++ b/arch/arm/mach-mvebu/armada-370-xp.h
@@ -20,6 +20,8 @@
 
 void armada_mpic_send_doorbell(const struct cpumask *mask, unsigned int irq);
 void armada_xp_mpic_smp_cpu_init(void);
+void armada_xp_secondary_startup(void);
+extern struct smp_operations armada_xp_smp_ops;
 #endif
 
 #endif /* __MACH_ARMADA_370_XP_H */
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index 4c84689..c23b077 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -22,6 +22,5 @@
 void mvebu_restart(enum reboot_mode mode, const char *cmd);
 
 void armada_xp_cpu_die(unsigned int cpu);
-void armada_xp_secondary_startup(void);
-extern struct smp_operations armada_xp_smp_ops;
+
 #endif
-- 
1.8.3.2
