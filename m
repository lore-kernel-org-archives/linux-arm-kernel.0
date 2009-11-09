From: arve@android.com (=?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?=)
Date: Sun, 8 Nov 2009 18:14:45 -0800
Subject: dream: glue for mmc controller
In-Reply-To: <20091108091009.GB20529@n2100.arm.linux.org.uk>
References: <20091103105319.GA2492@elf.ucw.cz>
	<20091103105737.GE20341@fluff.org.uk>
	<20091108081314.GA16482@elf.ucw.cz>
	<20091108091009.GB20529@n2100.arm.linux.org.uk>
Message-ID: <d6200be20911081814y286d58d2yf3d9eb7e6ddffa5b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 8, 2009 at 1:10 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Nov 08, 2009 at 09:13:14AM +0100, Pavel Machek wrote:
>> > > +#include <asm/io.h>
>> > > +#include <asm/gpio.h>
>> > linux/gpio.h
>> > linux/io.h
>>
>> I got compile errors when trying to use linux/gpio.h:
>>
>> arch/arm/mach-msm/board-dream-gpio.c: In function
>> 'dream_gpio_configure':
>> arch/arm/mach-msm/board-dream-gpio.c:109: error: 'GPIOF_OUTPUT_LOW'
>> undeclared (first use in this function)
>
> This means it's abusing the gpio header files - which are intended for
> the generic GPIO support, but are being used for this platforms private
> non-generic GPIO based stuff.
>

It also means that CONFIG_GENERIC_GPIO is not set, so linux/gpio.h
stubbed out all the gpio functions.

-- 
Arve Hj?nnev?g
