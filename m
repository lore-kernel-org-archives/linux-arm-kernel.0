From: eric@anholt.net (Eric Anholt)
Date: Fri, 15 May 2015 11:25:27 -0700
Subject: RaspberryPi SoC (mach) changes due for v4.2
In-Reply-To: <3591304.HkmxZFlZfG@wuerfel>
References: <20150514092543.GF22418@x1> <3591304.HkmxZFlZfG@wuerfel>
Message-ID: <871tihofzc.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Thursday 14 May 2015 10:25:43 Lee Jones wrote:
>> Eric Anholt (3):
>>       ARM: bcm2835: Skip doing our own iotable_init() initialization
>>       ARM: bcm2835: Drop the init_irq() hook
>>       ARM: bcm2835: Move the restart/power_off handling to the WDT driver
>> 
>> 
>
> Very nice!
>
> Do you already know if the bcm2836 support will be ready in time for 4.2?

For 2836 we need the firmware driver, dt-clocks driver, and extension of
the interrupt controller.  I also need to rebase the 2836 series to
handle the dtsi sharing better.  Unless getting review and acceptance
speeds up massively, I'd be skeptical of it even for 4.3 -- just mbox
took 2 months to land, and firmware, dt-clocks, bcm2836 intc, and
bcm2836 dtsi are each of similar scale.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150515/193a36ce/attachment-0001.sig>
