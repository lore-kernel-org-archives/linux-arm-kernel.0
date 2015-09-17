From: tony@atomide.com (Tony Lindgren)
Date: Wed, 16 Sep 2015 17:02:04 -0700
Subject: [PATCH] ARM: OMAP2+: AM43XX: Enable autoidle for clks in
 am43xx_init_late
In-Reply-To: <1442346454-5305-1-git-send-email-d-gerlach@ti.com>
References: <1442346454-5305-1-git-send-email-d-gerlach@ti.com>
Message-ID: <20150917000203.GD4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [150915 12:51]:
> Add omap2_clk_enable_autoidle_all to am43xx_init_late otherwise the call
> to omap2_clk_disable_autoidle_all in am43xx_init_early may cause some
> clocks to always stay active and prevent low power mode transitions.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Applying into omap-for-v4.3/fixes thanks.

Tony

> ---
>  arch/arm/mach-omap2/io.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 980c937..3eaeaca 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -676,6 +676,7 @@ void __init am43xx_init_early(void)
>  void __init am43xx_init_late(void)
>  {
>  	omap_common_late_init();
> +	omap2_clk_enable_autoidle_all();
>  }
>  #endif
>  
> -- 
> 2.4.6
> 
