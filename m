From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 27 Jan 2014 01:08:18 -0500
Subject: [PATCH 3/9] idle: no more arch_cpu_idle_prepare() users
In-Reply-To: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1390802904-28399-4-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... so we can get rid of it entirely.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 include/linux/cpu.h | 1 -
 kernel/cpu/idle.c   | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 03e235ad1b..218fab7521 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -221,7 +221,6 @@ void cpu_idle(void);
 void cpu_idle_poll_ctrl(bool enable);
 
 void arch_cpu_idle(void);
-void arch_cpu_idle_prepare(void);
 void arch_cpu_idle_enter(void);
 void arch_cpu_idle_exit(void);
 void arch_cpu_idle_dead(void);
diff --git a/kernel/cpu/idle.c b/kernel/cpu/idle.c
index 988573a9a3..4e327e211b 100644
--- a/kernel/cpu/idle.c
+++ b/kernel/cpu/idle.c
@@ -52,7 +52,6 @@ static inline int cpu_idle_poll(void)
 }
 
 /* Weak implementations for optional arch specific functions */
-void __weak arch_cpu_idle_prepare(void) { }
 void __weak arch_cpu_idle_enter(void) { }
 void __weak arch_cpu_idle_exit(void) { }
 void __weak arch_cpu_idle_dead(void) { }
@@ -136,6 +135,5 @@ void cpu_startup_entry(enum cpuhp_state state)
 	boot_init_stack_canary();
 #endif
 	__current_set_polling();
-	arch_cpu_idle_prepare();
 	cpu_idle_loop();
 }
-- 
1.8.4.108.g55ea5f6
