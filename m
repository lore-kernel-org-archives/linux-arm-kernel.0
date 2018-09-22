From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 21 Sep 2018 22:12:52 -0500
Subject: [PATCHv2 0/3] omap gpio add level idle, cpu_pm and drop
 runtime_irq_safe
In-Reply-To: <20180920193532.7714-1-tony@atomide.com>
References: <20180920193532.7714-1-tony@atomide.com>
Message-ID: <e3dbeb73-c14e-282b-f2bb-449131d6ed33@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/20/2018 02:35 PM, Tony Lindgren wrote:
> Hi,
> 
> Here's v2 of the patches to add support for omap4 and later level interrupt
> idle support, get rid of the custom pm calls, and finally after these we can
> drop pm_runtime_irq_safe().
> 
> Linus, assuming people are happy with these, I'd appreciate an immutable branch
> with these in case we run into merge conflicts for arch/arm/mach-omap2 changes.
> 
> Regards,
> 
> Tony
> 
> 
> Changes since v1:
> - Fix issue noted in v1 set and update comments accordingly
> 
> - Don't call pm_runtime from cpu_pm to avoid further dependencies to
>    pm_runtime_irq_safe() as discussed offline with Grygorii
> 
> - Add a patch to drop pm_runtime_irq_safe() as it's no longer needed
> 
> Tony Lindgren (3):
>    gpio: omap: Add level wakeup handling for omap4 based SoCs
>    gpio: omap: Remove custom PM calls and use cpu_pm instead
>    gpio: omap: Get rid of pm_runtime_irq_safe()
> 
>   arch/arm/mach-omap2/pm24xx.c            |   7 +-
>   arch/arm/mach-omap2/pm34xx.c            |  14 +-
>   drivers/gpio/gpio-omap.c                | 331 ++++++++++++++++--------
>   include/linux/platform_data/gpio-omap.h |  15 +-
>   4 files changed, 237 insertions(+), 130 deletions(-)
> 

Thank you
Acked-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
