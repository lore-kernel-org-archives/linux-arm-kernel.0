From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 23 Jan 2012 12:52:14 +0100
Subject: [PATCH 1/1] ARM: Developed device driver for Atmel TSADC
 controller
In-Reply-To: <20120123113647.GX1068@n2100.arm.linux.org.uk>
References: <n> <1327317907-2874-1-git-send-email-pettno@gmail.com>
 <20120123113647.GX1068@n2100.arm.linux.org.uk>
Message-ID: <4F1D49EE.6020600@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2012 12:36 PM, Russell King - ARM Linux :
> On Mon, Jan 23, 2012 at 12:25:06PM +0100, Petter Nordby wrote:
>> Some Atmel AT91 devices contains a touchscreen analog to digital
>> converter. This device driver use the ADC as a multi-channel raw
>> data input device.
>>
>> Tested on AT91SAM9G45 boards.
>>
>> Signed-off-by: Petter Nordby <pettno@gmail.com>
>> ---
>>  CREDITS                                    |    4 +
> 
> Shouldn't this be in MAINTAINERS?
> 
>>  arch/arm/configs/at91sam9g45_defconfig     |    1 +
>>  arch/arm/mach-at91/include/mach/at91_adc.h |   16 ++
>>  drivers/misc/Kconfig                       |    7 +
>>  drivers/misc/Makefile                      |    1 +
>>  drivers/misc/atmel_tsadc.c                 |  361 ++++++++++++++++++++++++++++
> 
> We have a proper abstraction of input devices under drivers/input which
> includes touchscreens.  I suggest using that rather than developing
> your own private kernel API.

Petter,

Be sure that I appreciate the submission of your work. Examples of code
and new drivers are always a big strength of the Open Source community.

But as Russell suggested, this use of ADC for AT91SAM9G45 family (TSADC)
will be better suited for the IIO subsystem.
A new AT91 ADC driver designed for this IIO subsystem has been developed
a little time ago:
"[PATCH RESEND v13] AT91: Add a driver for the ADC"

It will likely be included shortly in mainline kernel. I advice to
follow this development and add the support of SAM9G45 ADC to this
existing infrastructure.

I guess that the input/touchsreen part of the TSADC is not the purpose
of your driver:
drivers/input/touchscreen/atmel_tsadcc.c
will take care of this feature.

Best regards,
-- 
Nicolas Ferre
