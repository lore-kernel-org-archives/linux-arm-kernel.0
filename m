From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 18 May 2010 20:18:58 -0600
Subject: [PATCH 17/22] OMAP: timers: Fix clock source names for OMAP4
In-Reply-To: <20100519021800.19716.8938.stgit@localhost.localdomain>
References: <20100519021800.19716.8938.stgit@localhost.localdomain>
Message-ID: <20100519021856.19716.41561.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

The clock sources for timers on OMAP4 (system clock and 32k
clock) have their names wronly populated.
This patch fixes them so the omap_dm_timer_set_source
does not fail anymore.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/dmtimer.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 4d99dfb..c64875f 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -264,8 +264,8 @@ static struct omap_dm_timer omap4_dm_timers[] = {
 	{ .phys_base = 0x4a320000, .irq = OMAP44XX_IRQ_GPT12 },
 };
 static const char *omap4_dm_source_names[] __initdata = {
-	"sys_ck",
-	"omap_32k_fck",
+	"sys_clkin_ck",
+	"sys_32k_ck",
 	NULL
 };
 static struct clk *omap4_dm_source_clocks[2];
