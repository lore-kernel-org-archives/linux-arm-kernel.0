From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 20 Oct 2010 17:35:06 +0900
Subject: [PATCH 4/4] ARM: S5PV310: Add audio platform devices
In-Reply-To: <1287472517-563-1-git-send-email-jassisinghbrar@gmail.com>
References: <1287472517-563-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <05cf01cb7031$b558df80$200a9e80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar wrote:
> 
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> Define platform devices for all audio devices found on S5PV310
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  arch/arm/mach-s5pv310/Makefile    |    1 +
>  arch/arm/mach-s5pv310/dev-audio.c |  356
> +++++++++++++++++++++++++++++++++++++
>  2 files changed, 357 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv310/dev-audio.c
> 

(snip)

> +static int s5pv310_cfg_i2s(struct platform_device *pdev)
> +{
> +	/* configure GPIO for i2s port */
> +	switch (pdev->id) {
> +	case 0:
> +		s3c_gpio_cfgpin(S5PV310_GPZ(0), S3C_GPIO_SFN(2));
> +		s3c_gpio_cfgpin(S5PV310_GPZ(1), S3C_GPIO_SFN(2));
> +		s3c_gpio_cfgpin(S5PV310_GPZ(2), S3C_GPIO_SFN(2));
> +		s3c_gpio_cfgpin(S5PV310_GPZ(3), S3C_GPIO_SFN(2));
> +		s3c_gpio_cfgpin(S5PV310_GPZ(4), S3C_GPIO_SFN(2));
> +		s3c_gpio_cfgpin(S5PV310_GPZ(5), S3C_GPIO_SFN(2));
> +		s3c_gpio_cfgpin(S5PV310_GPZ(6), S3C_GPIO_SFN(2));

s3c_gpio_cfgpin_range(S5PV310_GPZ(0), 7, S3C_GPIO_SFN(2));

(snip)

> +
> +static struct resource s5pv310_iis0_resource[] = {
> +	[0] = {
> +		.start = S5PV310_PA_IIS0,
                      ^
> +		.end   = S5PV310_PA_IIS0 + 0x100 - 1,
                    ^^^
> +		.flags = IORESOURCE_MEM,
                      ^

It would be better if you could use tab above like following.

		.start	= S5PV310_PA_IIS0,
		.end	= S5PV310_PA_IIS0 + 0x100 - 1,
		.flags	= IORESOURCE_MEM,

(snip)

> +
> +struct platform_device s5pv310_device_iis0 = {
> +	.name		  = "samsung-i2s",
> +	.id		  = 0,
> +	.num_resources	  = ARRAY_SIZE(s5pv310_iis0_resource),
> +	.resource	  = s5pv310_iis0_resource,
> +	.dev = {
> +		.platform_data = &i2sv5_pdata,
> +	},
> +};
> +

I'm thinking about the name of IIS/I2S...Hmm...

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
