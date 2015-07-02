From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 2 Jul 2015 22:04:59 +0200
Subject: [PATCH] clk: mvebu: update cpu clock frequency
In-Reply-To: <1435866158-910-1-git-send-email-gregory.clement@free-electrons.com>
References: <1435866158-910-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150702200459.GF13481@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 02, 2015 at 09:42:38PM +0200, Gregory CLEMENT wrote:
> Since u-boot 2015_T1.0p6 there are new requency settings available.

Hi Gregory

Missing f in f_requency.

Also, what has u-boot got to do with this? I would expect this is a
property of the hardware. What happens is an older u-boot is used?

Thanks
	Andrew

> 
> Based on a patch from Nadav Haklai <nadavh@marvell.com>
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/clk/mvebu/armada-38x.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/mvebu/armada-38x.c b/drivers/clk/mvebu/armada-38x.c
> index 8bccf4ecdab6..c64037e2e89f 100644
> --- a/drivers/clk/mvebu/armada-38x.c
> +++ b/drivers/clk/mvebu/armada-38x.c
> @@ -46,10 +46,11 @@ static u32 __init armada_38x_get_tclk_freq(void __iomem *sar)
>  }
>  
>  static const u32 armada_38x_cpu_frequencies[] __initconst = {
> -	0, 0, 0, 0,
> -	1066 * 1000 * 1000, 0, 0, 0,
> +	666 * 1000 * 1000, 0, 800 * 1000 * 1000, 0,
> +	1066 * 1000 * 1000, 0, 1200 * 1000 * 1000, 0,
>  	1332 * 1000 * 1000, 0, 0, 0,
> -	1600 * 1000 * 1000,
> +	1600 * 1000 * 1000, 0, 0, 0,
> +	1866 * 1000 * 1000, 0, 0, 2000 * 1000 * 1000,
>  };
>  
>  static u32 __init armada_38x_get_cpu_freq(void __iomem *sar)
> -- 
> 2.1.0
> 
