From: srinidhi.kasagar@stericsson.com (Srinidhi KASAGAR)
Date: Thu, 21 Apr 2011 10:44:07 +0200
Subject: [RFC PATCH 06/12] ARM: ux500: use remapped PPI interrupts for
	local timer
In-Reply-To: <1303326501-15664-7-git-send-email-marc.zyngier@arm.com>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>
	<1303326501-15664-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <C832F8F5D375BD43BFA11E82E0FE9FE00AEE891699@EXDCVYMBSTM005.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
> Sent: Thursday, April 21, 2011 12:38 AM
> To: LAK
> Cc: Srinidhi KASAGAR; Linus WALLEIJ
> Subject: [RFC PATCH 06/12] ARM: ux500: use remapped PPI interrupts for
> local timer
> 
> Use the normal interrupt scheme for the local timers by using
> a remapped PPI interrupt.
> 
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-ux500/Kconfig      |    1 +
>  arch/arm/mach-ux500/localtimer.c |    3 ++-
>  2 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
> index 5862601..6f3eb99 100644
> --- a/arch/arm/mach-ux500/Kconfig
> +++ b/arch/arm/mach-ux500/Kconfig
> @@ -4,6 +4,7 @@ config UX500_SOC_COMMON
>  	bool
>  	default y
>  	select ARM_GIC
> +	select ARM_GIC_VPPI

Here you added VPPI and in the other patch 12/12 you remove this
again and make it one time selectable based on CONFIG_SMP.
is that done just for readability purpose?

Otherwise, for mach-ux500:
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>

srinidhi
