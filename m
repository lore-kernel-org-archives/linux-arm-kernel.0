From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 1 Oct 2013 13:01:36 -0300
Subject: [PATCH 2/4] ARM: kirkwood: Remove unneeded PCIe clock adding
In-Reply-To: <1380575010-8573-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380575010-8573-3-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131001160135.GA3998@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 06:03:28PM -0300, Ezequiel Garcia wrote:
> Since the PCIe devices is properly initialized from the DT, the clocks
> are now referenced in the device tree nodes, and it's not needed
> to have this hack to add them explicitly.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-kirkwood/board-dt.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index ee6297e..1bbced8 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -44,14 +44,6 @@ static void __init kirkwood_legacy_clk_init(void)
>  	clkspec.np = np;
>  	clkspec.args_count = 1;
>  
> -	clkspec.args[0] = CGC_BIT_PEX0;
> -	orion_clkdev_add("0", "pcie",
> -			 of_clk_get_from_provider(&clkspec));
> -
> -	clkspec.args[0] = CGC_BIT_PEX1;
> -	orion_clkdev_add("1", "pcie",
> -			 of_clk_get_from_provider(&clkspec));
> -
>  	/*
>  	 * The ethernet interfaces forget the MAC address assigned by
>  	 * u-boot if the clocks are turned off. Until proper DT support
> -- 
> 1.8.1.5
> 

If anyone with a PCIe Kirkwood board can give this patch a try
it would be great to have some Tested-by's.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
