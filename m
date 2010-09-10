From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 10 Sep 2010 13:25:31 +0200
Subject: [PATCH] AT91: at91sam9261ek board: remove warnings related to
	use of SPI or SD/MMC
In-Reply-To: <20100910110632.GT9112@game.jcrosoft.org>
References: <1284113629-13768-1-git-send-email-nicolas.ferre@atmel.com>
	<1284113629-13768-2-git-send-email-nicolas.ferre@atmel.com>
	<4C8A07BA.9090805@ru.mvista.com>
	<20100910110632.GT9112@game.jcrosoft.org>
Message-ID: <4C8A15AB.4030209@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 10/09/2010 13:06, Jean-Christophe PLAGNIOL-VILLARD :
>>>   * ADS7846 Touchscreen
>>> @@ -357,6 +350,21 @@ static struct spi_board_info ek_spi_devices[] = {
>>>  #endif
>>>  };
>>>
>>> +#else /* CONFIG_SPI_ATMEL_* */
>>> +
>>> +/*
>>> + * MCI (SD/MMC)
>>> + * spi0 and mmc/sd share the same PIO pins: cannot be used at the same time
>>> + */
>>> +static struct at91_mmc_data __initdata ek_mmc_data = {
>>> +	.wire4		= 1,
>>> +//	.det_pin	= ... not connected
>>> +//	.wp_pin		= ... not connected
>>> +//	.vcc_pin	= ... not connected
>>
>>    The coding style document forbids C99 style // comments. Could
>> replace with normal comment or #if 0...
> no dead code please

I kept those comments because it is just a move of code.

But ok, it seem that they are not liked by several people. As I am in a
"tiny fixes" mood, I post an additional patch to remove them ;-)

Cheers,
-- 
Nicolas Ferre
