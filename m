From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 27 May 2011 12:30:22 -0700
Subject: [RFC PATCH v4 11/13] ARM: gic: remove previous local timer
	interrupt handling
In-Reply-To: <1306513671-12206-12-git-send-email-marc.zyngier@arm.com>
References: <1306513671-12206-1-git-send-email-marc.zyngier@arm.com>
	<1306513671-12206-12-git-send-email-marc.zyngier@arm.com>
Message-ID: <4DDFFBCE.8020908@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2011 09:27 AM, Marc Zyngier wrote:
> Now that all users of local timers are using CONFIG_ARM_GIC_VPPI,
> the now unused local timer infrastructure can be safely removed.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>

Can you also remove local_timer_ack() from MSM in this patch? If you do,
feel free to add an

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

to this patch.

---8<----

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 186abdf..9c08b1c 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -298,12 +298,6 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
        clockevents_register_device(evt);
        return 0;
 }
-
-inline int local_timer_ack(void)
-{
-       return 1;
-}
-
 #endif
 
 struct sys_timer msm_timer = {


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
