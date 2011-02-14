From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Feb 2011 15:46:01 +0000
Subject: [PATCH 2/2] mach-mmp: Support for SD/MMC clock adjustment in
	brownstone
In-Reply-To: <9C2307EC-8314-40D5-A33B-38834F0F4698@marvell.com>
References: <9C2307EC-8314-40D5-A33B-38834F0F4698@marvell.com>
Message-ID: <20110214154601.GA31103@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 13, 2011 at 10:56:22PM -0800, Philip Rakity wrote:
> 
> Set timing for brownstone for SD/MMC cards to enable detection
> timing adjustments are needed when speed > 25MHz
> remove limitation on maximum speed of 25MHz
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  arch/arm/mach-mmp/brownstone.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
> index 0e92fd7..35afe60 100644
> --- a/arch/arm/mach-mmp/brownstone.c
> +++ b/arch/arm/mach-mmp/brownstone.c
> @@ -178,14 +178,22 @@ static struct i2c_board_info brownstone_twsi1_info[] = {
>  };
>  
>  static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
> -	.max_speed	= 25000000,
> +	.adjust_clocks	= 1,
> +	.clk_select	= 1,
> +	.clk_delay	= 31,
>  };
>  
>  static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 = {
> +	.adjust_clocks	= 1,
> +	.clk_select	= 1,
> +	.clk_delay	= 15,
>  	.flags		= PXA_FLAG_CARD_PERMANENT,
>  };
>  
>  static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 = {
> +	.adjust_clocks	= 1,
> +	.clk_select	= 1,
> +	.clk_delay	= 31,

You create the new fields in patch 1 and then add values to them in patch 2.
However, they remain unused, so it's impossible to see what the point of
creating them was.
