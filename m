From: ulf.samuelsson@atmel.com (Ulf Samuelsson)
Date: Sat, 27 Mar 2010 12:06:33 +0100
Subject: request_irq in I2C driver causes kernel to freeze duringprobe,
	but if done later - no problem!
References: <4BAD406A.7070208@atmel.com>
	<20100326232421.GG29179@n2100.arm.linux.org.uk>
	<4BAD4FDE.2010904@atmel.com> <4BAD5450.7020605@atmel.com>
	<20100327011223.GG31126@trinity.fluff.org>
	<4BADAD55.1080304@atmel.com>
	<20100327101132.GA9724@n2100.arm.linux.org.uk>
Message-ID: <0AB70C4BEF8D4E31B7147561BB63BE82@aeglos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On Sat, Mar 27, 2010 at 08:01:41AM +0100, Ulf Samuelsson wrote:
>> I assume that, since I request interrupt on falling edge
>> the interrupt will not be activated until the target
>> provides a new falling edge on the interrupt line.
>
> Does your interrupt controller support falling edge IRQs on the I2C
> controller?  Most SoCs provide you with only one fixed triggering
> method for on-board devices, which is normally only level sensitive.
>


It is not the I2C interrupt, it is a GPIO interrupt used by the external 
device
indicating it needs service

The problem only occurs when the request_irq is executed in the probe.
I have written a sysfs routine which will do the request_irq, later when I 
get a shell.
With this, rather cumbesome, method, everything seems to work OK.

Best Regards
Ulf Samuelsson
