From: ben@trinity.fluff.org (Ben Dooks)
Date: Tue, 11 May 2010 02:10:48 +0100
Subject: [PATCH 4/4] ARM: S3C6410: Declare IISv4 audio-bus clock
In-Reply-To: <1268115034-5998-4-git-send-email-jassisinghbrar@gmail.com>
References: <1268115034-5998-1-git-send-email-jassisinghbrar@gmail.com>
	<1268115034-5998-2-git-send-email-jassisinghbrar@gmail.com>
	<1268115034-5998-3-git-send-email-jassisinghbrar@gmail.com>
	<1268115034-5998-4-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <20100511011048.GH6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 09, 2010 at 03:10:34PM +0900, jassisinghbrar at gmail.com wrote:
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> Declare 'audio-bus' clock for IISv4 controller of S3C6410.
> Even though the name is same as that for IISv3, the id is
> set to -1(just one instance of the controller is available)
> which helps always fetch the correct clock.

merged onto for-2635/samsung-clock.
 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  arch/arm/mach-s3c64xx/clock.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
> index 6c286d5..da83595 100644
> --- a/arch/arm/mach-s3c64xx/clock.c
> +++ b/arch/arm/mach-s3c64xx/clock.c
> @@ -670,6 +670,16 @@ static struct clksrc_clk clksrcs[] = {
>  		.sources	= &clkset_audio1,
>  	}, {
>  		.clk	= {
> +			.name		= "audio-bus",
> +			.id		= -1,  /* There's only one IISv4 port */
> +			.ctrlbit        = S3C6410_CLKCON_SCLK_AUDIO2,
> +			.enable		= s3c64xx_sclk_ctrl,
> +		},
> +		.reg_src	= { .reg = S3C6410_CLK_SRC2, .shift = 0, .size = 3  },
> +		.reg_div	= { .reg = S3C_CLK_DIV2, .shift = 24, .size = 4  },
> +		.sources	= &clkset_audio2,
> +	}, {
> +		.clk	= {
>  			.name		= "irda-bus",
>  			.id		= 0,
>  			.ctrlbit        = S3C_CLKCON_SCLK_IRDA,
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
