From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  2 Jan 2012 18:38:45 -0200
Subject: [PATCH v2] ARM: setup.c: Fix build warning by removing unneeded
 header file
In-Reply-To: <1325535113-26551-1-git-send-email-festevam@gmail.com>
References: <1325535113-26551-1-git-send-email-festevam@gmail.com>
Message-ID: <1325536725-28403-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build warning:

  CC      arch/arm/kernel/setup.o
In file included from arch/arm/kernel/setup.c:39:
arch/arm/include/asm/elf.h:102:1: warning: "vmcore_elf64_check_arch" redefined
In file included from arch/arm/kernel/setup.c:24:
include/linux/crash_dump.h:30:1: warning: this is the location of the previous definition

Since commit 93a72052 (crash_dump: export is_kdump_kernel to modules, consolidate elfcorehdr_addr, setup_elfcorehdr and saved_max_pfn)
the inclusion of <linux/crash_dump.h> is no longer needed.

Remove the inclusion of <linux/crash_dump.h> and the build warning is fixed.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Instead of changing the order of the includes, simply remove the unneeded crash_dump.h header.
 arch/arm/kernel/setup.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 129fbd5..303bdb2 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -21,7 +21,6 @@
 #include <linux/init.h>
 #include <linux/kexec.h>
 #include <linux/of_fdt.h>
-#include <linux/crash_dump.h>
 #include <linux/root_dev.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
-- 
1.7.1
