From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 23 Sep 2015 08:39:43 +0200
Subject: [PATCH v2 1/2] ARM: Availability of psci_smp_available depends on
 CONFIG_SMP
In-Reply-To: <cover.1442990383.git.jan.kiszka@siemens.com>
References: <cover.1442990383.git.jan.kiszka@siemens.com>
Message-ID: <8b94f7869972d64f442f97208707a5856cbc8b14.1442990383.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that we can use psci_smp_available without checking for
CONFIG_SMP first.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/include/asm/psci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
index 68ee3ce..ff956f4 100644
--- a/arch/arm/include/asm/psci.h
+++ b/arch/arm/include/asm/psci.h
@@ -16,7 +16,7 @@
 
 extern struct smp_operations psci_smp_ops;
 
-#ifdef CONFIG_ARM_PSCI
+#if defined(CONFIG_ARM_PSCI) && defined(CONFIG_SMP)
 bool psci_smp_available(void);
 #else
 static inline bool psci_smp_available(void) { return false; }
-- 
2.1.4
