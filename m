From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 27 Mar 2010 10:11:32 +0000
Subject: request_irq in I2C driver causes kernel to freeze during
	probe, but if done later - no problem!
In-Reply-To: <4BADAD55.1080304@atmel.com>
References: <4BAD406A.7070208@atmel.com>
	<20100326232421.GG29179@n2100.arm.linux.org.uk>
	<4BAD4FDE.2010904@atmel.com> <4BAD5450.7020605@atmel.com>
	<20100327011223.GG31126@trinity.fluff.org>
	<4BADAD55.1080304@atmel.com>
Message-ID: <20100327101132.GA9724@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 27, 2010 at 08:01:41AM +0100, Ulf Samuelsson wrote:
> I assume that, since I request interrupt on falling edge
> the interrupt will not be activated until the target
> provides a new falling edge on the interrupt line.

Does your interrupt controller support falling edge IRQs on the I2C
controller?  Most SoCs provide you with only one fixed triggering
method for on-board devices, which is normally only level sensitive.
