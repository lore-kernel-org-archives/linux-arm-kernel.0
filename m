From: Baohua.Song@csr.com (Barry Song)
Date: Thu, 22 Sep 2011 22:51:28 -0700
Subject: [PATCH 1/4] ARM: CSR: timer: do not initialise statics to 0 or NULL
In-Reply-To: <1316757091-14916-1-git-send-email-Baohua.Song@csr.com>
References: <1316757091-14916-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1316757091-14916-2-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/timer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-prima2/timer.c b/arch/arm/mach-prima2/timer.c
index ed7ec48..225ed3b 100644
--- a/arch/arm/mach-prima2/timer.c
+++ b/arch/arm/mach-prima2/timer.c
@@ -133,7 +133,7 @@ static struct irqaction sirfsoc_timer_irq = {
 /* Overwrite weak default sched_clock with more precise one */
 unsigned long long notrace sched_clock(void)
 {
-	static int is_mapped = 0;
+	static int is_mapped;
 
 	/*
 	 * sched_clock is called earlier than .init of sys_timer
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
