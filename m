From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 04 Mar 2011 10:39:32 +0900
Subject: [PATCH 7/7] ARM: SMDK6410: Update regulator names for debugfs
	compatiblity
In-Reply-To: <1299164315-22246-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20110303145710.GA32234@opensource.wolfsonmicro.com>
	<1299164315-22246-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <022401cbda0d$08d18550$1a748ff0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> The debugfs support added to the regulator API (which has been merged
> in during this merge window) creates directories for regulators named
> after the display names for the regulators so replace / as a separator
> for multiple supplies with + in the SMDK6410 machine.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/mach-smdk6410.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-
> s3c64xx/mach-smdk6410.c
> index 4094707..2f30c79 100644
> --- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> @@ -353,7 +353,7 @@ static struct regulator_init_data smdk6410_vddpll
> __initdata = {
>  /* VDD_UH_MMC, LDO5 on J5 */
>  static struct regulator_init_data smdk6410_vdduh_mmc __initdata = {

Mark, there is no '__initdata' in my tree.
I just applied following changes (/ -> +).

If any updates/patches, please let me know :)

>  	.constraints = {
> -		.name = "PVDD_UH/PVDD_MMC",
> +		.name = "PVDD_UH+PVDD_MMC",
>  		.always_on = 1,
>  	},
>  };

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
