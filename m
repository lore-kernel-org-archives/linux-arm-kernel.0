From: B02280@freescale.com (Chen Jie-B02280)
Date: Wed, 31 Aug 2011 02:00:13 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENILVYyIDIvMl0gQVJNOiBteDUzL2xvY286IGFkZCBwd20g?=
	=?gb2312?Q?backlight_device?=
In-Reply-To: <20110830101800.GB26905@n2100.arm.linux.org.uk>
References: <1314699093-30276-1-git-send-email-jason.chen@freescale.com>
	<1314699093-30276-2-git-send-email-jason.chen@freescale.com>,
	<20110830101800.GB26905@n2100.arm.linux.org.uk>
Message-ID: <33F32152BE7EC740BC2C838D2836AC871986D7@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi, Russell,

Pls see my comments below:

Jason Chen / ? ?

Tel: +86 21 28937178

Freescale Semiconductor (China) Limited
Shanghai Branch Office

No.192 Liangjing Rd.,
Pudong New Area, Shanghai, 201203

________________________________________
???: Russell King - ARM Linux [linux at arm.linux.org.uk]
????: 2011?8?30? 18:18
?: Chen Jie-B02280
Cc: s.hauer at pengutronix.de; Jason Chen; eric.miao at linaro.org; linux-arm-kernel at lists.infradead.org; Chen Jie-B02280
??: Re: [PATCH-V2 2/2] ARM: mx53/loco: add pwm backlight device

On Tue, Aug 30, 2011 at 06:11:33PM +0800, jason.chen at freescale.com wrote:
> diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
> index 524538a..4409406 100644
> --- a/arch/arm/plat-mxc/include/mach/devices-common.h
> +++ b/arch/arm/plat-mxc/include/mach/devices-common.h
> @@ -301,3 +301,11 @@ struct platform_device *__init imx_add_spi_imx(
>  struct platform_device *imx_add_imx_dma(void);
>  struct platform_device *imx_add_imx_sdma(char *name,
>       resource_size_t iobase, int irq, struct sdma_platform_data *pdata);
> +
> +#include <linux/pwm_backlight.h>
> +static inline struct platform_device *__init imx_add_pwm_backlight(
> +     const int id, const struct platform_pwm_backlight_data *pdata)
> +{
> +     return platform_device_register_resndata(NULL, "pwm-backlight",\
> +                     id, NULL, 0, pdata, sizeof(*pdata));
> +}

1. It's normal for include statements to be at the top of the file.
[Jason] the old devices-common.h file has a structure of function define after a header file, if keep coherence, the header file had better be here. Maybe we could put another patch to move all header files to top of the file later?
2. \ at the end of a line is not necessary to split a line of C code -
   it really only matters for strings and the preprocessor.
[Jason] Ok
3. 'const int id' is just silly.  What are you const'ing?  The _copy_
   of the parameter that was passed?  const doesn't make sense for
   plain integer arguments.
[Jason] Ok
