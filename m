From: horms@verge.net.au (Simon Horman)
Date: Tue, 26 Feb 2013 13:29:46 +0900
Subject: [PATCH 1/4] ARM: shmobile: sh73a0: fix Z and ZG clock hierarchy
In-Reply-To: <1361553474-27022-2-git-send-email-g.liakhovetski@gmx.de>
References: <1361553474-27022-1-git-send-email-g.liakhovetski@gmx.de>
 <1361553474-27022-2-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <20130226042946.GB26820@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 06:17:51PM +0100, Guennadi Liakhovetski wrote:
> Z and ZG clocks on sh73a0 have pll0 as their parent, not pll1.

Thanks I have applied this to the soc5 branch and thus queued it up for v3.10.
Please let me know if you would prefer me to push it as a fix for v3.9.
And in that vein, if you regard it as -stable material.

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  arch/arm/mach-shmobile/clock-sh73a0.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
> index 5fa106b..71843dd 100644
> --- a/arch/arm/mach-shmobile/clock-sh73a0.c
> +++ b/arch/arm/mach-shmobile/clock-sh73a0.c
> @@ -265,12 +265,12 @@ enum { DIV4_I, DIV4_ZG, DIV4_M3, DIV4_B, DIV4_M1, DIV4_M2,
>  
>  static struct clk div4_clks[DIV4_NR] = {
>  	[DIV4_I] = DIV4(FRQCRA, 20, 0xdff, CLK_ENABLE_ON_INIT),
> -	[DIV4_ZG] = DIV4(FRQCRA, 16, 0xd7f, CLK_ENABLE_ON_INIT),
> +	[DIV4_ZG] = SH_CLK_DIV4(&pll0_clk, FRQCRA, 16, 0xd7f, CLK_ENABLE_ON_INIT),
>  	[DIV4_M3] = DIV4(FRQCRA, 12, 0x1dff, CLK_ENABLE_ON_INIT),
>  	[DIV4_B] = DIV4(FRQCRA, 8, 0xdff, CLK_ENABLE_ON_INIT),
>  	[DIV4_M1] = DIV4(FRQCRA, 4, 0x1dff, 0),
>  	[DIV4_M2] = DIV4(FRQCRA, 0, 0x1dff, 0),
> -	[DIV4_Z] = DIV4(FRQCRB, 24, 0x97f, 0),
> +	[DIV4_Z] = SH_CLK_DIV4(&pll0_clk, FRQCRB, 24, 0x97f, 0),
>  	[DIV4_ZTR] = DIV4(FRQCRB, 20, 0xdff, 0),
>  	[DIV4_ZT] = DIV4(FRQCRB, 16, 0xdff, 0),
>  	[DIV4_ZX] = DIV4(FRQCRB, 12, 0xdff, 0),
> -- 
> 1.7.2.5
> 
