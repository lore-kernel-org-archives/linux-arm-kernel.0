From: mturquette@ti.com (Mike Turquette)
Date: Tue, 12 Jun 2012 10:03:06 -0700
Subject: [PATCH 2/5] ARM: at91: Implementation of PMC clks using the
 common clk framework.
In-Reply-To: <1336812838-3649-3-git-send-email-linux-arm@overkiz.com>
References: <1336812838-3649-1-git-send-email-linux-arm@overkiz.com>
 <1336812838-3649-3-git-send-email-linux-arm@overkiz.com>
Message-ID: <20120612170306.GD19410@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120512-10:53, Boris BREZILLON wrote:
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index 79d0f60..29f8812 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -6,8 +6,11 @@ obj-y		:= irq.o gpio.o setup.o
>  obj-m		:=
>  obj-n		:=
>  obj-		:=
> -
> +ifeq ($(CONFIG_COMMON_CLK),y)
> +obj-$(CONFIG_AT91_PMC_UNIT)	+= pmc-osc.o pmc-pll.o pmc-master.o pmc-sys.o pmc-periph.o pmc-prog.o pmc.o
> +else
>  obj-$(CONFIG_AT91_PMC_UNIT)	+= clock.o
> +endif

Hi Boris,

Looks like the old platform clock code is not removed in this series.
Is this just a work in progress or do you want to merge in AT91 support
for common clk while leaving the old clock code merged in?

Regards,
Mike
