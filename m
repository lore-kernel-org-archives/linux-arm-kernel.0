From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 31 May 2011 16:10:00 -0700
Subject: [PATCH] msm: timer: Fix SMP build error
Message-ID: <1306883400-32711-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix build breakage on SMP=y builds due to 0f7b332 (ARM:
consolidate SMP cross call implementation, 2011-04-03)

arch/arm/mach-msm/timer.c: In function 'local_timer_setup':
arch/arm/mach-msm/timer.c:295: error: implicit declaration of
function 'gic_enable_ppi'

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/timer.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 38b95e9..9bfdd5a 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -23,6 +23,8 @@
 #include <linux/io.h>
 
 #include <asm/mach/time.h>
+#include <asm/hardware/gic.h>
+
 #include <mach/msm_iomap.h>
 #include <mach/cpu.h>
 
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
