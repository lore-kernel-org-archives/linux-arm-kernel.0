From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 21 Nov 2014 14:55:44 +0400
Subject: IRQ #0 broken on ARM
In-Reply-To: <20141121105333.GP27002@pengutronix.de>
References: <CALT56yPs-SSssff1waj81CRQfER4ZKKR=B1jOXVL-aBChicSjg@mail.gmail.com>
 <20141121103456.GR4042@n2100.arm.linux.org.uk>
 <20141121105333.GP27002@pengutronix.de>
Message-ID: <CALT56yO+H-hJYYCxWigA4bTYO4OV74X9s1Y6PT-NZ52VvayPJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-21 13:53 GMT+03:00 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Fri, Nov 21, 2014 at 10:34:56AM +0000, Russell King - ARM Linux wrote:
>> On Fri, Nov 21, 2014 at 02:31:05PM +0400, Dmitry Eremin-Solenikov wrote:
>> > Hello,
>> >
>> > After the commit a71b092a9c68685a270ebdde7b5986ba8787e575
>> > (ARM: Convert handle_IRQ to use __handle_domain_irq) IRQ #0 is broken
>> > on ARM. It is a valid IRQ and it is quite imporant (on sa1100 it's a GPIO0).
>>
>> No, it is not a valid IRQ.  (It was a mistake to think it was.)
>> Generic code will always assume IRQ0 is not valid, and the fix is to
>> fix the places in ARM where we try to use it.
> To make this more understandable: Linux uses virtual irq numbers. The
> virtual irq 0 is invalid. For a given irq domain the (hardware) irq 0 is
> of course useful and can be supported. Still for a device driver (which
> uses the virtual irq space) 0 should always be invalid.

I was talking about virtual irq space, not hwirq.

-- 
With best wishes
Dmitry
