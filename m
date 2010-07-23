From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Fri, 23 Jul 2010 11:58:03 -0700
Subject: [PATCH 3/3] arm: macros for wfe, sev instructions
In-Reply-To: <1279911483-7039-1-git-send-email-johlstei@codeaurora.org>
References: <1279911483-7039-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1279911483-7039-4-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Muckle <smuckle@codeaurora.org>

The wait for event and send event instructions may be called from C code
such as boot or power management routines.

Signed-off-by: Steve Muckle <smuckle@codeaurora.org>
Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/include/asm/processor.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 7bed3da..4262664 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -97,6 +97,11 @@ unsigned long get_wchan(struct task_struct *p);
 #define cpu_relax()			barrier()
 #endif
 
+#if defined(CONFIG_CPU_32v6K) || __LINUX_ARM_ARCH__ >= 7
+#define sev() __asm__("sev")
+#define wfe() __asm__("wfe")
+#endif
+
 /*
  * Create a new kernel thread
  */
-- 
1.7.1.1
