From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Thu, 30 Apr 2015 09:44:31 -0500
Subject: [PATCH 16/18] ARM: imx: Move the variable clockevent_mode into
 mxc_set_mode
In-Reply-To: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <1430405073-13106-17-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The global variable "clockevent_mode" was moved into the
function of mxc_set_mode.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
 arch/arm/mach-imx/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 836d255..da4dc29 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -98,7 +98,6 @@ struct imx_timer {
 };
 
 static struct clock_event_device clockevent_mxc;
-static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
 
 static void gpt_irq_disable_v0_v1(struct imx_timer *tm)
 {
@@ -226,6 +225,7 @@ static void mxc_set_mode(enum clock_event_mode mode,
 {
 	unsigned long flags;
 	struct imx_timer *tm = container_of(evt, struct imx_timer, evt);
+	static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
 
 	/*
 	 * The timer interrupt generation is disabled at least
-- 
1.9.1
