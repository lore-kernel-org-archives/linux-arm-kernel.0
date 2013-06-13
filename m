From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 13 Jun 2013 10:13:39 +0800
Subject: [PATCH V2 3/3] ARM: tegra114: cpuidle: add powered-down state
In-Reply-To: <51B8B2C8.1090006@wwwdotorg.org>
References: <1370342880-422-1-git-send-email-josephl@nvidia.com>
 <1370342880-422-4-git-send-email-josephl@nvidia.com>
 <51AE5EE3.3010607@linaro.org>  <51B8B2C8.1090006@wwwdotorg.org>
Message-ID: <1371089619.1681.21.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-06-13 at 01:41 +0800, Stephen Warren wrote:
> On 06/04/2013 03:40 PM, Daniel Lezcano wrote:
> > On 06/04/2013 12:48 PM, Joseph Lo wrote:
> >> This supports CPU core power down on each CPU when CPU idle. When CPU go
> >> into this state, it saves it's context and needs a proper configuration
> >> in flow controller to power gate the CPU when CPU runs into WFI
> >> instruction. And the CPU also needs to set the IRQ as CPU power down idle
> >> wake up event in flow controller.
> >>
> >> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> > 
> > I would like to understand why there is a WARN with the
> > CPUIDLE_FLAG_TIMER_STOP flag set before queuing this patch and ensure it
> > is not the tree hiding the forest.
> 
> Joseph, are you planning to post an updated series or respond to resolve
> Daniel's question?

I need more time to investigate the detail about what caused the WARN
when apply the flag. And what's the difference if we didn't enable
CONFIG_CPU_IDLE_MULTIPLE_DRIVERS, then it only applies
CLOCK_EVT_NOTIFY_BROADCAST_ON on CPU0. Why if I am moving the
clockevent_notify of CLOCK_EVT_NOTIFY_BROADCAST_EXIT before
"local_irq_enable" in the
"cpuidle_enter_state" (drivers/cpuidle/cpuidle.c), then the warning
message gone?

Daniel,

Because I need more time to figure it out, are you OK if I can post
another patch to apply CPUIDLE_FLAG_TIMER_STOP flag for all Tegra CPU
Idle drivers later? (Once we know what's the problem behind this)

Stephen,

I don't have an update of this series, if Daniel is OK if I can post
another patch to apply TIMER_STOP flag for all Tegra idle drivers.

Thanks,
Joseph
