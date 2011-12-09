From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Dec 2011 16:49:51 -0800
Subject: [PATCH] OMAP2, 3: DSS2: Include linux/delay.h and common.h to
 fix build errors
In-Reply-To: <1322654481.11191.1.camel@phoenix>
References: <1322654481.11191.1.camel@phoenix>
Message-ID: <20111209004951.GK31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Axel Lin <axel.lin@gmail.com> [111130 03:26]:
> Include linux/delay.h to fix below build error:
> 
>   CC      arch/arm/mach-omap2/display.o
> arch/arm/mach-omap2/display.c: In function 'dispc_disable_outputs':
> arch/arm/mach-omap2/display.c:283: error: implicit declaration of function 'mdelay'
> arch/arm/mach-omap2/display.c: In function 'omap_dss_reset':
> arch/arm/mach-omap2/display.c:317: error: implicit declaration of function 'omap_test_timeout'
> make[1]: *** [arch/arm/mach-omap2/display.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> 
> Include common.h to fix below build error:
> 
>   CC      arch/arm/mach-omap2/display.o
> arch/arm/mach-omap2/display.c: In function 'omap_dss_reset':
> arch/arm/mach-omap2/display.c:318: error: implicit declaration of function 'omap_test_timeout'
> make[1]: *** [arch/arm/mach-omap2/display.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> I got the build error on linux-next 20111130.
> This patch is against linux-next 20111130.
> Axel

Thanks we already have commit deee6d5359969a0ce4e2760cfd7b9f379bd5698a
in Russell's devel-stable branch doing the same thing.

Regards,

Tony
