From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 27 Apr 2010 09:46:51 +0530
Subject: [PATCH 13/14] ux500: rename cpu-u8500.c to cpu-db8500.c
In-Reply-To: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
References: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1272341812-4622-14-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the DB8500-specific file to a more appropriate name.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/Makefile                      |    2 +-
 arch/arm/mach-ux500/{cpu-u8500.c => cpu-db8500.c} |    0
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/arm/mach-ux500/{cpu-u8500.c => cpu-db8500.c} (100%)

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 55651e0..2eb7685 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -3,6 +3,6 @@
 #
 
 obj-y				:= clock.o cpu.o devices.o
-obj-$(CONFIG_ARCH_U8500)	+= cpu-u8500.o devices-db8500.o
+obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o
 obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o localtimer.o
diff --git a/arch/arm/mach-ux500/cpu-u8500.c b/arch/arm/mach-ux500/cpu-db8500.c
similarity index 100%
rename from arch/arm/mach-ux500/cpu-u8500.c
rename to arch/arm/mach-ux500/cpu-db8500.c
-- 
1.7.0
