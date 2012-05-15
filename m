From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 15 May 2012 17:58:12 +0900
Subject: [PATCH 2/2] ARM: S3C64XX: Hook up carrier class modules on
 Cragganmore
In-Reply-To: <1337016041-16096-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1337016041-16096-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1337016041-16096-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <07fc01cd3278$dbbf63f0$933e2bd0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> We now have an additional classs of modules which are enumerated at I2C
> address 0x22. Add hookup for these modules.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
> index 0787b91..48eb76f 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> @@ -674,6 +674,7 @@ static struct i2c_board_info i2c_devs1[] __initdata = {
>  	  .platform_data = &glenfarclas_pmic_pdata },
> 
>  	{ I2C_BOARD_INFO("wlf-gf-module", 0x20) },
> +	{ I2C_BOARD_INFO("wlf-gf-module", 0x22) },
>  	{ I2C_BOARD_INFO("wlf-gf-module", 0x24) },
>  	{ I2C_BOARD_INFO("wlf-gf-module", 0x25) },
>  	{ I2C_BOARD_INFO("wlf-gf-module", 0x26) },
> --
> 1.7.10

Looks good to me, but there is no '{ I2C_BOARD_INFO("wlf-gf-module", 0x20) },' in my tree.

Just adding address 0x22 stuff is enough now?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
