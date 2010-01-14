From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 14 Jan 2010 00:41:04 +0000
Subject: [PATCH 2.6.33] SMDK6410: Specify no GPIO for B_PWR_5V regulator
In-Reply-To: <1263391024-29502-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1263391024-29502-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20100114004104.GN18532@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2010 at 01:57:04PM +0000, Mark Brown wrote:
> Since the fixed voltage regulator grew support for GPIO based
> enables and GPIO 0 is valid on some systems we need to specify
> that there is no valid GPIO enable control.

should this be posted for -rc?
 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> Sorry, resend due to thinkoed list address.
> 
>  arch/arm/mach-s3c6410/mach-smdk6410.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
> index 8eb8d2c..bc3b1fd 100644
> --- a/arch/arm/mach-s3c6410/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
> @@ -211,6 +211,7 @@ static struct fixed_voltage_config smdk6410_b_pwr_5v_pdata = {
>  	.supply_name = "B_PWR_5V",
>  	.microvolts = 5000000,
>  	.init_data = &smdk6410_b_pwr_5v_data,
> +	.gpio = -EINVAL,
>  };
>  
>  static struct platform_device smdk6410_b_pwr_5v = {
> -- 
> 1.6.6
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
