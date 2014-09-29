From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Sep 2014 18:08:39 +0200
Subject: [PATCH v1 2/4] arm: pxa: move init functions into generic.h
In-Reply-To: <1411973508-14301-2-git-send-email-robert.jarzmik@free.fr>
References: <1411973508-14301-1-git-send-email-robert.jarzmik@free.fr>
 <1411973508-14301-2-git-send-email-robert.jarzmik@free.fr>
Message-ID: <3547658.YqqGlbv966@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 September 2014 08:51:46 Robert Jarzmik wrote:
> 
>  #ifdef CONFIG_PXA25x
> +#define pxa25x_handle_irq icip_handle_irq
>  extern unsigned pxa25x_get_clk_frequency_khz(int);
> +extern void __init pxa25x_init_irq(void);
> +extern void __init pxa25x_map_io(void);
> +#ifdef CONFIG_CPU_PXA26x
> +extern void __init pxa26x_init_irq(void);
> +#endif
>  #else
>  #define pxa25x_get_clk_frequency_khz(x)                (0)
>  #endif
> 

It's better to add the declarations outside of the #ifdef. I believe
the existing #ifdef is meant to provide a dummy alternative, but you
don't actually want that for the other declarations, so just add them
to a globally visible location.

	Arnd
