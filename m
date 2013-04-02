From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 02 Apr 2013 17:48:20 +0100
Subject: [PATCH v2 08/13] ARM: vexpress: remove extra timer-sp control
 register clearing
In-Reply-To: <1364854883-5961-9-git-send-email-robherring2@gmail.com>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
 <1364854883-5961-9-git-send-email-robherring2@gmail.com>
Message-ID: <1364921300.3019.39.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-04-01 at 23:21 +0100, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> The timer-sp initialization code clears the control register before
> initializing the timers, so every platform doing this is redundant.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/mach-vexpress/v2m.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> index cdc29d8..09e571d 100644
> --- a/arch/arm/mach-vexpress/v2m.c
> +++ b/arch/arm/mach-vexpress/v2m.c
> @@ -61,9 +61,6 @@ static void __init v2m_sp804_init(void __iomem *base, unsigned int irq)
>  	if (WARN_ON(!base || irq == NO_IRQ))
>  		return;
>  
> -	writel(0, base + TIMER_1_BASE + TIMER_CTRL);
> -	writel(0, base + TIMER_2_BASE + TIMER_CTRL);
> -
>  	sp804_clocksource_init(base + TIMER_2_BASE, "v2m-timer1");
>  	sp804_clockevents_init(base + TIMER_1_BASE, irq, "v2m-timer0");
>  }

Acked-by: Pawel Moll <pawel.moll@arm.com>

Thanks!

Pawel
