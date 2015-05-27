From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 May 2015 11:11:22 +0800
Subject: [PATCH v3 12/12] ARM: imx: move timer driver into
 drivers/clocksource
In-Reply-To: <1432530849-12312-1-git-send-email-shawn.guo@linaro.org>
References: <1432308599-28643-13-git-send-email-shawn.guo@linaro.org>
 <1432530849-12312-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20150527031121.GC16165@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 25, 2015 at 01:14:09PM +0800, Shawn Guo wrote:
> After the cleanup on imx timer driver, now it's ready to be moved into
> drivers/clocksource/.  Let's do it.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Hi Daniel,

What's your option on this?  I plan to send this to arm-soc folks via
i.MX tree for 4.2, but need your ACK on this one.

Shawn

> ---
> Changes since v2:
>  - Rename the file to timer-imx-gpt.c
> 
>  arch/arm/mach-imx/Makefile                                      | 2 +-
>  drivers/clocksource/Makefile                                    | 1 +
>  arch/arm/mach-imx/time.c => drivers/clocksource/timer-imx-gpt.c | 0
>  3 files changed, 2 insertions(+), 1 deletion(-)
>  rename arch/arm/mach-imx/time.c => drivers/clocksource/timer-imx-gpt.c (100%)
> 
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 799e65a530be..f70e18470799 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -1,4 +1,4 @@
> -obj-y := time.o cpu.o system.o irq-common.o
> +obj-y := cpu.o system.o irq-common.o
>  
>  obj-$(CONFIG_SOC_IMX1) += mm-imx1.o
>  obj-$(CONFIG_SOC_IMX21) += mm-imx21.o
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 5b85f6adb258..579e4bcf8763 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -52,3 +52,4 @@ obj-$(CONFIG_ARCH_INTEGRATOR_AP)	+= timer-integrator-ap.o
>  obj-$(CONFIG_CLKSRC_VERSATILE)		+= versatile.o
>  obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
>  obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
> +obj-$(CONFIG_ARCH_MXC)			+= timer-imx-gpt.o
> diff --git a/arch/arm/mach-imx/time.c b/drivers/clocksource/timer-imx-gpt.c
> similarity index 100%
> rename from arch/arm/mach-imx/time.c
> rename to drivers/clocksource/timer-imx-gpt.c
> -- 
> 1.9.1
> 
