From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Dec 2011 09:55:30 -0800
Subject: [PATCH 08/20] ARM: mach-gemini: move special idle code out of line
In-Reply-To: <1324288069-21940-9-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
 <1324288069-21940-9-git-send-email-nico@fluxnic.net>
Message-ID: <20111219175529.GI6464@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [111219 01:32]:
> --- a/arch/arm/mach-gemini/irq.c
> +++ b/arch/arm/mach-gemini/irq.c
> @@ -73,8 +73,8 @@ void __init gemini_init_irq(void)
>  	unsigned int i, mode = 0, level = 0;
>  
>  	/*
> -	 * Disable arch_idle() by default since it is buggy
> -	 * For more info see arch/arm/mach-gemini/include/mach/system.h
> +	 * Disable the idle handler by default since it is buggy
> +	 * For more info see arch/arm/mach-gemini/idle.c 
>  	 */
>  	disable_hlt();

FYI while applying using stg, got a "<stdin>:88: trailing whitespace."
error here.

Tony
