From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 20 May 2013 02:50:17 +0000 (UTC)
Subject: [PATCH 1/2] ARM: OMAP AM33XX: clock data: Enable clkout2 as part
 of init
In-Reply-To: <1367919574-21353-2-git-send-email-hvaibhav@ti.com>
References: <1367919574-21353-1-git-send-email-hvaibhav@ti.com>
 <1367919574-21353-2-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.00.1305200248280.2656@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 May 2013, Vaibhav Hiremath wrote:

> clkout2 comes out on the pad and is being used by various
> external on-board peripherals like, Audio codecs and stuff.
> So enable the clkout2 by default during init sequence itself.

I don't like this: the clock should be enabled by the drivers for those 
external peripherals, not enabled by default.  So I think you should 
reconsider the part of the patch that enables it upon init.  But if you 
really want to do this, I'm not inclined to stand in the way; you can add 
my ack.

- Paul

> 
> Also, add the missing entry of "clkout2_ck" to the clock table.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  arch/arm/mach-omap2/cclock33xx_data.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
> index 6fd0ed1..a8140b6 100644
> --- a/arch/arm/mach-omap2/cclock33xx_data.c
> +++ b/arch/arm/mach-omap2/cclock33xx_data.c
> @@ -979,6 +979,7 @@ static struct omap_clk am33xx_clks[] = {
>  	CLK(NULL,	"trace_pmd_clk_mux_ck",	&trace_pmd_clk_mux_ck),
>  	CLK(NULL,	"stm_clk_div_ck",	&stm_clk_div_ck),
>  	CLK(NULL,	"trace_clk_div_ck",	&trace_clk_div_ck),
> +	CLK(NULL,	"clkout2_ck",		&clkout2_ck),
>  };
>  
>  
> @@ -989,6 +990,7 @@ static const char *enable_init_clks[] = {
>  	"l4hs_gclk",
>  	"l4fw_gclk",
>  	"l4ls_gclk",
> +	"clkout2_ck",	/* Required for external peripherals like, Audio codecs */
>  };
>  
>  int __init am33xx_clk_init(void)
> -- 
> 1.7.0.4
> 


- Paul
