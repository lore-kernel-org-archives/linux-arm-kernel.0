From: tony@atomide.com (Tony Lindgren)
Date: Tue, 10 Apr 2018 06:41:49 -0700
Subject: [PATCH] ARM: avoid Cortex-A9 livelock on tight dmb loops
In-Reply-To: <E1f5qij-00033R-Sl@rmk-PC.armlinux.org.uk>
References: <E1f5qij-00033R-Sl@rmk-PC.armlinux.org.uk>
Message-ID: <20180410134149.GQ5700@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@armlinux.org.uk> [180410 10:43]:
> diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
> index 021b5a8b9c0a..d4ddc78b2a0b 100644
> --- a/arch/arm/mach-omap2/prm_common.c
> +++ b/arch/arm/mach-omap2/prm_common.c
> @@ -523,7 +523,7 @@ void omap_prm_reset_system(void)
>  	prm_ll_data->reset_system();
>  
>  	while (1)
> -		cpu_relax();
> +		cpu_do_idle();
>  }
>  

Hmm we need to check so the added WFI here does not cause an
undesired change to a low power state. Adding Tero to Cc also.

Regards,

Tony
