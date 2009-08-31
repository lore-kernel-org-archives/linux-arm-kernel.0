From: psanchez@fosstel.com (Pedro I. Sanchez)
Date: Mon, 31 Aug 2009 15:02:01 -0400
Subject: AT91SAM9260: How to output PCK0 clock on a GPIO pin
In-Reply-To: <4A9C1A03.2050908@gabaedevelopment.com>
References: <fb43ffa34296dae697dbadb98e53bdc1@colcan.ca>
	<4A9C0136.3080102@gabaedevelopment.com>
	<bb8f28f395b9416e1c2b1877be6f3baf@colcan.ca>
	<4A9C1A03.2050908@gabaedevelopment.com>
Message-ID: <8af7bfc16c944615552acda12c469e9f@colcan.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 31 Aug 2009 14:44:19 -0400, Stephen Munnings
<smunnings@gabaedevelopment.com> wrote:
> Pedro I. Sanchez wrote:
>>> But, I also found that you must have the PMC clock for the GPIOC bank 
>>> running before GPIO (even the configuration, it seems) will work.
>>> I am not sure if I had this issue in Linux, or only in the loaders, but

>>> I did have to turn on the PMC clocks to get any GPIO based things
>>> working.
>>>     
>>> The standard boot loader only seems to turn on GPIOA, but I am also 
>>> using GPIOB and GPIOC, and I had to turn on the PMC clocks for those
>>> also before I could get very far.
>>>
>>> Stephen Munnings
>>>     
>>
>> Thanks Stephen,
>>
>> And how do I turn on the PMC clocks for the GPIO?
>>
>>   
> I did some more searching, and it appears that Linux for at91 turns on 
> all the GPIO PMC clocks as part
> of its initialization.  So, the problem appears to not be the PMC clocks.
> (It does it in /arch/arm/mach-at91/gpio.c in function at91_gpio_init() )
> 
> I do presume that you have the appropriate support configured into your 
> kernel when you compiled it.

$ grep -i clocks .config
CONFIG_AT91_PROGRAMMABLE_CLOCKS=y

$ grep -i gpio .config
CONFIG_GENERIC_GPIO=y
# CONFIG_MTD_NAND_GPIO is not set
CONFIG_I2C_GPIO=m
CONFIG_SPI_GPIO=m
CONFIG_ARCH_REQUIRE_GPIOLIB=y
CONFIG_GPIOLIB=y
CONFIG_GPIO_SYSFS=y
# Memory mapped GPIO expanders:
# I2C GPIO expanders:
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCF857X=m
# PCI GPIO expanders:
# SPI GPIO expanders:
CONFIG_GPIO_MAX7301=m
CONFIG_GPIO_MCP23S08=m
# CONFIG_HTC_EGPIO is not set
CONFIG_LEDS_GPIO=y

I presume I don't need any to modprobe any of these available gpio modules.
Certainly the gpio user space interface via /sys/class/gpio works well.

Any other suggestions?

Thanks,

-- 
Pedro
