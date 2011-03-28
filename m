From: tony@atomide.com (Tony Lindgren)
Date: Mon, 28 Mar 2011 15:21:53 -0700
Subject: [PATCH 10/10] omap2+: Rename timer-gp.c into timer.c to combine timer
	init functions
In-Reply-To: <20110328221501.4046.41079.stgit@baageli.muru.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
Message-ID: <20110328222152.4046.25803.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can keep everything sys_timer and gptimer.c related code in
timer.c as the code will be very minimal.

Later on we can also remove timer-mpu.c, as it can be called from
omap4_timer_init function.

This allows us to get rid of confusing existing files. We currently
have timer-gp.c, timer-mpu.c, and patches have been posted to add
dmtimer.c. There's no need to have these multiple files, we can
put everything into timer.c.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile   |    2 +-
 arch/arm/mach-omap2/timer.c    |    0 
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/arm/mach-omap2/{timer-gp.c => timer.c} (100%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index a45cd64..04d04bb 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o \
+obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o pm.o \
 	 common.o gpio.o dma.o wd_timer.o
 
 omap-2-3-common				= irq.o sdrc.o
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer.c
similarity index 100%
rename from arch/arm/mach-omap2/timer-gp.c
rename to arch/arm/mach-omap2/timer.c
