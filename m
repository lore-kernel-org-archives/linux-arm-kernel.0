From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 14 Dec 2011 11:46:45 +0530
Subject: [PATCH V3] ARM: EXYNOS4: Modified files for SPI consolidation work
In-Reply-To: <1323875836-22594-1-git-send-email-padma.v@samsung.com>
References: <1323875836-22594-1-git-send-email-padma.v@samsung.com>
Message-ID: <4EE83F4D.7010100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Padma,

Some minor nitpicks ...

On 12/14/2011 08:47 PM, Padmavathi Venna wrote:
> As SPI platform devices are consolidated to plat-samsung, some
> corresponding changes are required in the respective machine folder.
> Setup files are added for SPI GPIO configurations and platform data
> initialization.
>
> Signed-off-by: Padmavathi Venna<padma.v@samsung.com>
> ---
[snip]

> +static struct clksrc_clk clk_sclk_spi0 = {
> +	.clk		= {
> +		.name		= "sclk_spi",
> +		.devname		= "s3c64xx-spi.0",

Single TAB would align properly.

+		.devname	= "s3c64xx-spi.0",

> +		.enable		= exynos4_clksrc_mask_peril1_ctrl,
> +		.ctrlbit		= (1<<  16),

+		.ctrlbit	= (1 << 16),

> +	},
> +	.sources =&clkset_group,
> +	.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 16, .size = 4 },
> +	.reg_div = { .reg = S5P_CLKDIV_PERIL1, .shift = 0, .size = 4 },
> +};
> +
> +static struct clksrc_clk clk_sclk_spi1 = {
> +	.clk		= {
> +		.name		= "sclk_spi",
> +		.devname		= "s3c64xx-spi.1",

+		.devname	= "s3c64xx-spi.1",

> +		.enable		= exynos4_clksrc_mask_peril1_ctrl,
> +		.ctrlbit		= (1<<  20),

+		.ctrlbit	= (1 << 20),

> +	},
> +	.sources =&clkset_group,
> +	.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 20, .size = 4 },
> +	.reg_div = { .reg = S5P_CLKDIV_PERIL1, .shift = 16, .size = 4 },
> +};
> +
> +static struct clksrc_clk clk_sclk_spi2 = {
> +	.clk		= {
> +		.name		= "sclk_spi",
> +		.devname		= "s3c64xx-spi.2",

+		.devname	= "s3c64xx-spi.2",

> +		.enable		= exynos4_clksrc_mask_peril1_ctrl,
> +		.ctrlbit		= (1<<  24),

+		.ctrlbit	= (1 << 24),

> +	},
> +	.sources =&clkset_group,
> +	.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 24, .size = 4 },
> +	.reg_div = { .reg = S5P_CLKDIV_PERIL2, .shift = 0, .size = 4 },
> +};

[ snip ]

> +int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
> +{
> +	s3c_gpio_cfgpin(EXYNOS4_GPB(0), S3C_GPIO_SFN(2));
> +	s3c_gpio_setpull(EXYNOS4_GPB(0), S3C_GPIO_PULL_UP);
> +	s3c_gpio_cfgall_range(EXYNOS4_GPB(2), 2,
> +			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
                           ^^^^
TAB instead of SPACE for indenting?

+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);


> +int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
> +{
> +	s3c_gpio_cfgpin(EXYNOS4_GPB(4), S3C_GPIO_SFN(2));
> +	s3c_gpio_setpull(EXYNOS4_GPB(4), S3C_GPIO_PULL_UP);
> +	s3c_gpio_cfgall_range(EXYNOS4_GPB(6), 2,
> +			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
			^^^^
Ditto.

+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);

> +	return 0;
> +}
> +#endif


> +int s3c64xx_spi2_cfg_gpio(struct platform_device *dev)
> +{
> +	s3c_gpio_cfgpin(EXYNOS4_GPC1(1), S3C_GPIO_SFN(5));
> +	s3c_gpio_setpull(EXYNOS4_GPC1(1), S3C_GPIO_PULL_UP);
> +	s3c_gpio_cfgall_range(EXYNOS4_GPC1(3), 2,
> +			      S3C_GPIO_SFN(5), S3C_GPIO_PULL_UP);
			^^^^
Ditto.

+				S3C_GPIO_SFN(5), S3C_GPIO_PULL_UP);

> +	return 0;
> +}
> +#endif


-- 
Tushar Behera
