From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Jun 2013 07:08:06 -0400
Subject: linux-next: manual merge of the mvebu tree with the imx-mxs tree
In-Reply-To: <20130606153600.a23c3489dc8b30d0836cb8ea@canb.auug.org.au>
References: <20130606153600.a23c3489dc8b30d0836cb8ea@canb.auug.org.au>
Message-ID: <20130606110806.GA23859@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 03:36:00PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the mvebu tree got a conflict in
> arch/arm/Kconfig.debug between commit 284166ffebc3 ("ARM: imx: enable
> low-level debug support for imx6sl") from the imx-mxs tree and commit
> 5be22d8c29fd ("arm: mvebu: add another earlyprintk Kconfig option") from
> the mvebu tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Looks good, thanks Stephen!

thx,

Jason.

> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
> 
> diff --cc arch/arm/Kconfig.debug
> index 29f7623,e6a6ab1..0000000
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@@ -639,9 -656,9 +664,10 @@@ config DEBUG_LL_INCLUD
>   				 DEBUG_IMX35_UART || \
>   				 DEBUG_IMX51_UART || \
>   				 DEBUG_IMX53_UART ||\
>  -				 DEBUG_IMX6Q_UART
>  +				 DEBUG_IMX6Q_UART || \
>  +				 DEBUG_IMX6SL_UART
> - 	default "debug/mvebu.S" if DEBUG_MVEBU_UART
> + 	default "debug/mvebu.S" if DEBUG_MVEBU_UART || \
> + 				   DEBUG_MVEBU_UART_ALTERNATE
>   	default "debug/mxs.S" if DEBUG_IMX23_UART || DEBUG_IMX28_UART
>   	default "debug/nomadik.S" if DEBUG_NOMADIK_UART
>   	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
