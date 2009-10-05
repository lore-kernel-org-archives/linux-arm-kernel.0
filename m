From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Mon, 05 Oct 2009 16:01:17 +0200
Subject: [PATCH] fix pcm037_eet compilation with the new SPI driver
In-Reply-To: <20091005121936.GD23986@pengutronix.de>
References: <Pine.LNX.4.64.0910051001500.4337@axis700.grange>
	<20091005121936.GD23986@pengutronix.de>
Message-ID: <4AC9FC2D.6000200@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Sascha Hauer wrote:
> 
> On Mon, Oct 05, 2009 at 10:04:51AM +0200, Guennadi Liakhovetski wrote:
>> At some point the SPI device name in arch/arm/mach-mx3/devices.c has 
>> changed, which then broke compilation of pcm037_eet with the new SPI 
>> driver. Use the correct name.
> 
> It didn't change, it was merged with imx_spi_device0. Can we change the
> name in devices.[ch] instead? All other devices start with mxc_. Sorry,
> my bad.

I don't really where it is changed ... mxc seems better so devices.[ch] 
is more logical.

But I have sent the exact same patch on Friday and received no comment 
... I hope mine or Guennadi's (I don't really care) can get its way to -rc4.

Val

> 
> Sascha
> 
> 
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> ---
>> diff --git a/arch/arm/mach-mx3/pcm037_eet.c b/arch/arm/mach-mx3/pcm037_eet.c
>> index 8d38600..dc6baf3 100644
>> --- a/arch/arm/mach-mx3/pcm037_eet.c
>> +++ b/arch/arm/mach-mx3/pcm037_eet.c
>> @@ -184,7 +184,7 @@ static int eet_init_devices(void)
>>  	/* SPI */
>>  	spi_register_board_info(pcm037_spi_dev, ARRAY_SIZE(pcm037_spi_dev));
>>  #if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
>> -	mxc_register_device(&mxc_spi_device0, &pcm037_spi1_master);
>> +	mxc_register_device(&imx_spi_device0, &pcm037_spi1_master);
>>  #endif
>>  
>>  	platform_device_register(&pcm037_gpio_keys_device);
>>
> 
