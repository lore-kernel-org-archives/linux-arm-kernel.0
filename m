From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 18 Feb 2011 19:14:09 -0800
Subject: [PATCH] msm: headsmp.S: Fix section mismatch
Message-ID: <1298085249-10518-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: vmlinux.o(.cpuinit.text+0xc80): Section mismatch in
reference from the function boot_secondary() to the variable
.init.text:msm_secondary_startup
The function __cpuinit boot_secondary() references a variable
__init msm_secondary_startup.  If msm_secondary_startup is only
used by boot_secondary then annotate msm_secondary_startup with
a matching annotation.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/headsmp.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/headsmp.S b/arch/arm/mach-msm/headsmp.S
index d0c2143..0c631a9 100644
--- a/arch/arm/mach-msm/headsmp.S
+++ b/arch/arm/mach-msm/headsmp.S
@@ -11,7 +11,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
-	__INIT
+	__CPUINIT
 
 /*
  * MSM specific entry point for secondary CPUs.  This provides
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
