From: horms@verge.net.au (Simon Horman)
Date: Mon, 3 Sep 2018 09:17:15 +0200
Subject: [PATCH] arm64: enable CMT/TMU support for Renesas SoC
In-Reply-To: <ebd7d1f7-d99b-f0a1-f05e-d822254b2e86@cogentembedded.com>
References: <ebd7d1f7-d99b-f0a1-f05e-d822254b2e86@cogentembedded.com>
Message-ID: <20180903071715.gim5ukqkmvxjp3vm@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 10:54:42PM +0300, Sergei Shtylyov wrote:
> Renesas R-Car gen3 SoCs have both CMT and TMU timers, so we have to enable
> building them in Kconfig.platforms (as they don't normally have the prompts
> in Kconfig).
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thank Sergei,

this looks fine to me and I'd be happy to take it through the renesas tree,
after others have been given time for review, if that is the appropriate
path for this patch.

> 
> ---
> The patch is against the ARM64 repo's 'for-next/core' branch.
> 
>  arch/arm64/Kconfig.platforms |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux/arch/arm64/Kconfig.platforms
> ===================================================================
> --- linux.orig/arch/arm64/Kconfig.platforms
> +++ linux/arch/arm64/Kconfig.platforms
> @@ -175,6 +175,8 @@ config ARCH_RENESAS
>  	select PM_GENERIC_DOMAINS
>  	select RENESAS_IRQC
>  	select SOC_BUS
> +	select SYS_SUPPORTS_SH_CMT
> +	select SYS_SUPPORTS_SH_TMU
>  	help
>  	  This enables support for the ARMv8 based Renesas SoCs.
>  
> 
