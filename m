From: yanjiang.jin@windriver.com (yanjiang.jin at windriver.com)
Date: Tue, 2 May 2017 17:47:17 +0800
Subject: [PATCH] kdump test comments:
Message-ID: <20170502094718.188172-1-yanjiang.jin@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yanjiang Jin <yanjiang.jin@windriver.com>

1. Execute a kdump test on a "Freescale LayerScape LS1021E, Version: 2.0 board";

2. I think may all "proc-v7-3level" CPUs need this patch, but I only validated it on LS1021, so still use

#ifdef CONFIG_SOC_LS1021A

   to wrap this change;

3. Append "crashkernel=128M at 2560M" in UBoot's command line;

4. Use uImage as kdump's first kernel and capture kernel, but ls1021A doesn't define LOADADDR now,
   so add below code in "arch/arm/boot/Makefile" temporarily to build an uImage:

+ifeq ($(CONFIG_SOC_LS1021A), y)
+LOADADDR=0x80008000
+endif
+

Yanjiang Jin (1):
  arm: proc-v7-3level.S: SOC_LS1021A: clear TTBCR.T1SZ

 arch/arm/mm/proc-v7-3level.S | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
1.9.1
