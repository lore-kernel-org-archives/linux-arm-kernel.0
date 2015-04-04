From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 4 Apr 2015 02:17:29 +0200
Subject: [PATCH 10/14] ARM: orion: use clkdev_create()
In-Reply-To: <E1Ye59d-0001BZ-Sv@rmk-PC.arm.linux.org.uk>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
 <E1Ye59d-0001BZ-Sv@rmk-PC.arm.linux.org.uk>
Message-ID: <20150404001729.GA14824@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 03, 2015 at 06:13:13PM +0100, Russell King wrote:
> clkdev_create() is a shorter way to write clkdev_alloc() followed by
> clkdev_add().  Use this instead.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew

> ---
>  arch/arm/plat-orion/common.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
> index f5b00f41c4f6..2235081a04ee 100644
> --- a/arch/arm/plat-orion/common.c
> +++ b/arch/arm/plat-orion/common.c
> @@ -28,11 +28,7 @@
>  void __init orion_clkdev_add(const char *con_id, const char *dev_id,
>  			     struct clk *clk)
>  {
> -	struct clk_lookup *cl;
> -
> -	cl = clkdev_alloc(clk, con_id, dev_id);
> -	if (cl)
> -		clkdev_add(cl);
> +	clkdev_create(clk, con_id, "%s", dev_id);
>  }
>  
>  /* Create clkdev entries for all orion platforms except kirkwood.
> -- 
> 1.8.3.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
