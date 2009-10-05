From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Mon, 05 Oct 2009 17:34:08 +0200
Subject: [PATCH v2] fix pcm037_eet compilation with the new SPI driver
In-Reply-To: <Pine.LNX.4.64.0910051644010.4337@axis700.grange>
References: <Pine.LNX.4.64.0910051001500.4337@axis700.grange>	<20091005121936.GD23986@pengutronix.de>
	<4AC9FC2D.6000200@epfl.ch>
	<Pine.LNX.4.64.0910051644010.4337@axis700.grange>
Message-ID: <4ACA11F0.4040506@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi and Sacha,

Guennadi Liakhovetski wrote:
> Fix pcm037_eet compilation with the new imx SPI driver by unifying 
> platform device names.

This looks fine to me and I have tested it with success.

> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Acked-by: Valentin Longchamp <valentin.longchamp@epfl.ch>

> ---
> On Mon, 5 Oct 2009, Valentin Longchamp wrote:
> 
>> Hi Sascha,
>>
>> Sascha Hauer wrote:
>>> On Mon, Oct 05, 2009 at 10:04:51AM +0200, Guennadi Liakhovetski wrote:
>>>> At some point the SPI device name in arch/arm/mach-mx3/devices.c has
>>>> changed, which then broke compilation of pcm037_eet with the new SPI
>>>> driver. Use the correct name.
>>> It didn't change, it was merged with imx_spi_device0. Can we change the
>>> name in devices.[ch] instead? All other devices start with mxc_. Sorry,
>>> my bad.
>> I don't really where it is changed ... mxc seems better so devices.[ch] is
>> more logical.
>>
>> But I have sent the exact same patch on Friday and received no comment ... I
>> hope mine or Guennadi's (I don't really care) can get its way to -rc4.
> 
> Sorry, I missed it. Here's a version with changed devices.[hc].

No problem, as long as it gets fixed.

> 
> diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
> index 8a577f3..e6abe18 100644
> --- a/arch/arm/mach-mx3/devices.c
> +++ b/arch/arm/mach-mx3/devices.c
> @@ -459,7 +459,7 @@ struct platform_device mxc_usbh2 = {
>   * SPI master controller
>   * 3 channels
>   */
> -static struct resource imx_spi_0_resources[] = {
> +static struct resource mxc_spi_0_resources[] = {
>  	{
>  	       .start = CSPI1_BASE_ADDR,
>  	       .end = CSPI1_BASE_ADDR + SZ_4K - 1,
> @@ -471,7 +471,7 @@ static struct resource imx_spi_0_resources[] = {
>  	},
>  };
>  
> -static struct resource imx_spi_1_resources[] = {
> +static struct resource mxc_spi_1_resources[] = {
>  	{
>  		.start = CSPI2_BASE_ADDR,
>  		.end = CSPI2_BASE_ADDR + SZ_4K - 1,
> @@ -483,7 +483,7 @@ static struct resource imx_spi_1_resources[] = {
>  	},
>  };
>  
> -static struct resource imx_spi_2_resources[] = {
> +static struct resource mxc_spi_2_resources[] = {
>  	{
>  		.start = CSPI3_BASE_ADDR,
>  		.end = CSPI3_BASE_ADDR + SZ_4K - 1,
> @@ -495,25 +495,25 @@ static struct resource imx_spi_2_resources[] = {
>  	},
>  };
>  
> -struct platform_device imx_spi_device0 = {
> +struct platform_device mxc_spi_device0 = {
>  	.name = "spi_imx",
>  	.id = 0,
> -	.num_resources = ARRAY_SIZE(imx_spi_0_resources),
> -	.resource = imx_spi_0_resources,
> +	.num_resources = ARRAY_SIZE(mxc_spi_0_resources),
> +	.resource = mxc_spi_0_resources,
>  };
>  
> -struct platform_device imx_spi_device1 = {
> +struct platform_device mxc_spi_device1 = {
>  	.name = "spi_imx",
>  	.id = 1,
> -	.num_resources = ARRAY_SIZE(imx_spi_1_resources),
> -	.resource = imx_spi_1_resources,
> +	.num_resources = ARRAY_SIZE(mxc_spi_1_resources),
> +	.resource = mxc_spi_1_resources,
>  };
>  
> -struct platform_device imx_spi_device2 = {
> +struct platform_device mxc_spi_device2 = {
>  	.name = "spi_imx",
>  	.id = 2,
> -	.num_resources = ARRAY_SIZE(imx_spi_2_resources),
> -	.resource = imx_spi_2_resources,
> +	.num_resources = ARRAY_SIZE(mxc_spi_2_resources),
> +	.resource = mxc_spi_2_resources,
>  };
>  
>  #ifdef CONFIG_ARCH_MX35
> diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
> index 79f2be4..ab87419 100644
> --- a/arch/arm/mach-mx3/devices.h
> +++ b/arch/arm/mach-mx3/devices.h
> @@ -20,7 +20,7 @@ extern struct platform_device mxc_otg_host;
>  extern struct platform_device mxc_usbh1;
>  extern struct platform_device mxc_usbh2;
>  extern struct platform_device mxc_rnga_device;
> -extern struct platform_device imx_spi_device0;
> -extern struct platform_device imx_spi_device1;
> -extern struct platform_device imx_spi_device2;
> +extern struct platform_device mxc_spi_device0;
> +extern struct platform_device mxc_spi_device1;
> +extern struct platform_device mxc_spi_device2;
