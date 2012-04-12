From: davidb@codeaurora.org (David Brown)
Date: Thu, 12 Apr 2012 11:45:34 -0700
Subject: [PATCH 2/2] ARM: msm: Fix section mismatches in proc_comm.c
In-Reply-To: <1334256334-8234-1-git-send-email-davidb@codeaurora.org>
References: <1334256334-8234-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1334256334-8234-2-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change
    commit 4416e9eb0b4859b3d28016c5fd0a609bdcbc8a2a
    Author: Gregory Bean <gbean@codeaurora.org>
    Date:   Wed Jul 28 10:22:12 2010 -0700

        arm: msm: Fix section mismatch in smd.c.

fixes a section mismatch between the board file and the smd driver's
probe function, however, it misses the additional mismatches between
the probe function and some routines it calls.  Fix these up as well.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/proc_comm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-msm/proc_comm.c b/arch/arm/mach-msm/proc_comm.c
index 67e701c..9980dc7 100644
--- a/arch/arm/mach-msm/proc_comm.c
+++ b/arch/arm/mach-msm/proc_comm.c
@@ -121,7 +121,7 @@ int msm_proc_comm(unsigned cmd, unsigned *data1, unsigned *data2)
  * and unknown state. This function should be called early to
  * wait on the ARM9.
  */
-void __init proc_comm_boot_wait(void)
+void __devinit proc_comm_boot_wait(void)
 {
 	void __iomem *base = MSM_SHARED_RAM_BASE;
  
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
