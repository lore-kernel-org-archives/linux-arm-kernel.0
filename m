From: eric@anholt.net (Eric Anholt)
Date: Fri, 28 Oct 2016 08:52:08 -0700
Subject: [PATCH v2] irqchip/bcm2836: Prevent spurious interrupts
In-Reply-To: <alpine.DEB.2.20.1610281257230.4896@nanos>
References: <20161027182038.11312-1-eric@anholt.net>
 <alpine.DEB.2.20.1610281257230.4896@nanos>
Message-ID: <87bmy4qxnb.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Thu, 27 Oct 2016, Eric Anholt wrote:
>
>> From: Phil Elwell <phil@raspberrypi.org>
>> 
>> The old arch-specific IRQ macros included a dsb to ensure the
>> write to clear the mailbox interrupt completed before returning
>> from the interrupt. The BCM2836 irqchip driver needs the same
>> precaution to avoid spurious interrupts.
>
> This is missing a fixes tag. I have no idea when that problem was
> introduced, so I have no way to decide whether this needs to be tagged
> stable or not.

This code has been there since introduction of the driver, so:

Fixes: 1a15aaa998dc ("irqchip: Add bcm2836 interrupt controller for Raspberry Pi 2")
