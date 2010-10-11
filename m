From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 12 Oct 2010 07:54:34 +0900
Subject: [PATCH V3] ARM: S5PV310: Add I2C channel 3, 4, 5, 6,
	and 7 device support
In-Reply-To: <1286784948-27094-1-git-send-email-m.szyprowski@samsung.com>
References: <1286455601-25360-4-git-send-email-m.szyprowski@samsung.com>
	<1286784948-27094-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <00ec01cb6997$48fe3ab0$dafab010$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> S5PV310 and S5PC210 support more I2C devices than previous SoCs.
> Add the device support code for them.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> 
> Changes since V2:
> - removed some s5p reference leftovers from V1
> - adapted setup-i2cX.c to use s3c_gpio_cfgall_range()
> - added missing entries in plat-samsung/include/plat/devs.h
> - added missing 'select HAVE_S3C2410_I2C' in KConfig
> 
Hi, Marek

Thanks for your update.

(snip)

> +void s3c_i2c4_cfg_gpio(struct platform_device *dev)
> +{
> +	s3c_gpio_cfgall_range(S5PV310_GPB(2), 2,
> +			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);

Following is from your previous patch.

void s3c_i2c4_cfg_gpio(struct platform_device *dev)
{
	s3c_gpio_cfgpin(S5PV310_GPB(0), S3C_GPIO_SFN(3));
	s3c_gpio_setpull(S5PV310_GPB(0), S3C_GPIO_PULL_UP);
	s3c_gpio_cfgpin(S5PV310_GPB(1), S3C_GPIO_SFN(3));
	s3c_gpio_setpull(S5PV310_GPB(1), S3C_GPIO_PULL_UP);
}

So...should be...
s3c_gpio_cfgall_range(S5PV310_GPB(0), 2, S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);

will fix it myself :-)

(snip)

others, ok to me...will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
