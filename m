From: horms@verge.net.au (Simon Horman)
Date: Thu, 9 May 2013 12:25:44 +0900
Subject: [PATCH] ARM: shmobile: fix sleep-r8a7740.S miscompiles
In-Reply-To: <201305081418.05091.arnd@arndb.de>
References: <201305081418.05091.arnd@arndb.de>
Message-ID: <20130509032544.GB13994@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 02:18:04PM +0200, Arnd Bergmann wrote:
> The newly added sleep-r8a7740.S file in shmobile does not
> actually build because of renamed symbols.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Bastian Hecht <hechtb+renesas@gmail.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> ---
> 
> Simon, please apply to whichever branch of yours has the broken commit,
> or fold this patch into Bastian's patch.
> 
> linux-next doesn't build for me because of this, mainline is still fine.

Sure, will do.

I am traveling today so I may not be able to deal with this
properly until tomorrow.

> 
> diff --git a/arch/arm/mach-shmobile/sleep-r8a7740.S b/arch/arm/mach-shmobile/sleep-r8a7740.S
> index 435531b..982eacb 100644
> --- a/arch/arm/mach-shmobile/sleep-r8a7740.S
> +++ b/arch/arm/mach-shmobile/sleep-r8a7740.S
> @@ -32,7 +32,7 @@ ENTRY(r8a7740_shutdown)
>  wfi_loop:
>  	bl	cpu_v7_do_idle
>  	b wfi_loop
> -ENDPROC(r8a7740)
> +ENDPROC(r8a7740_shutdown)
>  
>  	.text
>  ENTRY(v7_cpu_resume)
> @@ -53,5 +53,5 @@ ENDPROC(v7_cpu_resume)
>  ENTRY(r8a7740_resume)
>  	ldr	pc, 1f
>  1:	.long	v7_cpu_resume - PAGE_OFFSET + PLAT_PHYS_OFFSET
> -ENDPROC(r8a7740_resume_core_standby)
> +ENDPROC(r8a7740_resume)
>  #endif
> 
