From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Aug 2011 11:18:01 +0100
Subject: [PATCH-V2 2/2] ARM: mx53/loco: add pwm backlight device
In-Reply-To: <1314699093-30276-2-git-send-email-jason.chen@freescale.com>
References: <1314699093-30276-1-git-send-email-jason.chen@freescale.com>
	<1314699093-30276-2-git-send-email-jason.chen@freescale.com>
Message-ID: <20110830101800.GB26905@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2011 at 06:11:33PM +0800, jason.chen at freescale.com wrote:
> diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
> index 524538a..4409406 100644
> --- a/arch/arm/plat-mxc/include/mach/devices-common.h
> +++ b/arch/arm/plat-mxc/include/mach/devices-common.h
> @@ -301,3 +301,11 @@ struct platform_device *__init imx_add_spi_imx(
>  struct platform_device *imx_add_imx_dma(void);
>  struct platform_device *imx_add_imx_sdma(char *name,
>  	resource_size_t iobase, int irq, struct sdma_platform_data *pdata);
> +
> +#include <linux/pwm_backlight.h>
> +static inline struct platform_device *__init imx_add_pwm_backlight(
> +	const int id, const struct platform_pwm_backlight_data *pdata)
> +{
> +	return platform_device_register_resndata(NULL, "pwm-backlight",\
> +			id, NULL, 0, pdata, sizeof(*pdata));
> +}

1. It's normal for include statements to be at the top of the file.
2. \ at the end of a line is not necessary to split a line of C code -
   it really only matters for strings and the preprocessor.
3. 'const int id' is just silly.  What are you const'ing?  The _copy_
   of the parameter that was passed?  const doesn't make sense for
   plain integer arguments.
