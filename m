From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 4 Jul 2013 06:30:26 +0300
Subject: [PATCH] clocksource/cadence_ttc: Reuse clocksource as sched_clock
In-Reply-To: <1372888216-10726-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1372888216-10726-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <20130704033026.GX4288@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Soren,

On Wed, Jul 03, 2013 at 02:50:16PM -0700, Soren Brinkmann wrote:
> Reuse the TTC clocksource timer as sched clock, too. Since only a single
> sched clock is supported in Linux, this feature optional and can be
> selected through Kconfig.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---

[...]

> diff --git a/drivers/clocksource/cadence_ttc_timer.c 
> b/drivers/clocksource/cadence_ttc_timer.c
> index 4cbe28c..ef0f52b 100644
> --- a/drivers/clocksource/cadence_ttc_timer.c
> +++ b/drivers/clocksource/cadence_ttc_timer.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/slab.h>
>  #include <linux/clk-provider.h>
> +#include <asm/sched_clock.h>

This has changed to linux/sched_clock.h in the tip tree. See 
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=timers/core&id=38ff87f77af0b5a93fc8581cff1d6e5692ab8970.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
