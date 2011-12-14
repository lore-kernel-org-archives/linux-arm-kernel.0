From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Dec 2011 11:25:10 -0800
Subject: [PATCH v3 4/4] ARM: omap: pass minimal SoC/board data for UART
 from dt
In-Reply-To: <1323863746-18145-5-git-send-email-rnayak@ti.com>
References: <1323863746-18145-1-git-send-email-rnayak@ti.com>
 <1323863746-18145-5-git-send-email-rnayak@ti.com>
Message-ID: <20111214192509.GH32251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [111214 03:24]:
> Pass minimal data needed for console boot, from dt, for
> OMAP4 panda/sdp and OMAP3 beagle boards, and get rid of the
> static initialization from generic board file.
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

This we can't merge because this breaks serial console for
omap2 because you're not adding the omap2 specific dtsi
entries for omap2..

> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -69,7 +69,6 @@ static void __init omap_generic_init(void)
>  	if (node)
>  		irq_domain_add_simple(node, 0);
>  
> -	omap_serial_init();
>  	omap_sdrc_init(NULL, NULL);
>  
>  	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);

..and you're removing the call for omap_serial_init.

Please just update this patch with the omap2 entries
as well. Other than that looks good to me.

Tony
