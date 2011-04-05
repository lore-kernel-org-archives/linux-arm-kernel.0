From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 5 Apr 2011 13:29:23 -0300
Subject: [PATCH] leds: provide helper to register "leds-gpio" devices
In-Reply-To: <4D9B3FA8.1010407@freescale.com>
References: <20110405073030.GI13963@pengutronix.de>
	<1301992655-8514-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<4D9B3FA8.1010407@freescale.com>
Message-ID: <4D9B4363.8010606@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/5/2011 1:13 PM, Fabio Estevam wrote:
> Hi Uwe,
> 
> On 4/5/2011 5:37 AM, Uwe Kleine-K?nig wrote:
>> This function makes a deep copy of the platform data to allow it to live
>> in init memory.
>> The definition cannot go into leds-gpio.c because it needs to be builtin
>> to be usable by platforms.
>>
>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> I tested your patch on a MX53EVK board, but I could only build it after unselecting the mmc driver.
> 
> This is the error I got when mmc was selected:
> 
>   CC      drivers/mmc/card/mmc_test.o
>   LD      drivers/mmc/card/built-in.o
>   CC      drivers/mmc/core/sdio_io.o
> In file included from include/linux/mmc/host.h:13,
>                  from drivers/mmc/core/sdio_io.c:12:
> include/linux/leds.h:220: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'gpio_led_register_device'
> make[3]: *** [drivers/mmc/core/sdio_io.o] Error 1
> make[2]: *** [drivers/mmc/core] Error 2
> make[1]: *** [drivers/mmc] Error 2
> make: *** [drivers] Error 2

If I declare it as "platform_device *gpio_led_register_device" then it builds fine.

Regards,

Fabio Estevam
