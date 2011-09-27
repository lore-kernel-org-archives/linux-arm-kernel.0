From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 27 Sep 2011 18:21:36 +0800
Subject: [PATCH v3 0/3] genirq: handling GIC per-cpu interrupts
In-Reply-To: <1316793788-14500-1-git-send-email-marc.zyngier@arm.com>
References: <1316793788-14500-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110927102135.GD17997@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2011 at 05:03:05PM +0100, Marc Zyngier wrote:
> The current GIC per-cpu interrupts (aka PPIs) suffer from a number of
> problems:
> 
> - They use a completely separate scheme to handle the interrupts,
>   mostly because the PPI concept doesn't really match the kernel view
>   of an interrupt.
> - PPIs can only be used by the timer code, unless we add more low-level
>   assembly code.
> - The local timer code can only be used by devices generating PPIs,
>   and not SPIs.
> - At least one platform (msm) has started implementing its own
>   alternative scheme.
> - Some low-level code gets duplicated, as usual...
> 
> The proposed solution is to handle the PPIs using the same path as
> SPIs. A new core API is added to deal with per-cpu interrupts in a
> less awkward way. The local timer code is updated to reflect these
> changes.
> 
> The core API changes are based on an initial idea by Thomas Gleixner.
> 
> Tested on ARM Versatile Express (Cortex A15), ARM RealView PB11MP,
> OMAP4 (Panda) and Tegra (Harmony). Patch series against next-20110923.
> 
> From v2:
> - Fixed !GENERIC_HARDIRQS build
> - Fixed request_percpu_irq documentation
> 
> From v1:
> - General tidy-up after Thomas' review. I've kept the config option
>   for the time being until we can sort out the anonymous union
>   problem.
> 
> Marc Zyngier (3):
>   genirq: add support for per-cpu dev_id interrupts
>   ARM: gic: consolidate PPI handling
>   ARM: gic, local timers: use the request_percpu_irq() interface
> 
On imx6q:

Tested-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
