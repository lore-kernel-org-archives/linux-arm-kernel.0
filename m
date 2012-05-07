From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 7 May 2012 18:23:02 +0800
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <201205071014.03632.arnd@arndb.de>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <20120507090858.GN26481@n2100.arm.linux.org.uk>
 <20120507094718.GD4415@opensource.wolfsonmicro.com>
 <201205071014.03632.arnd@arndb.de>
Message-ID: <CAN1soZwwr21=JV=NE81aey-1nSMzg-37fXG7zjouALJaU345Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 7, 2012 at 6:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 07 May 2012, Mark Brown wrote:
>> > What if you have two devices both claiming IO regions at 0? ?Hint: it
>> > fails.
>>
>> Don't think I've got any examples with regions beginning at 0 but other
>> regions seem to not run into any problems with overlap. ?Note that all
>> these drivers do with the regions is use them to look up the base
>> register.
>
> ISA devices start at 0. Using a definition for IORESOURCE_IO of "PCI
> port number for relatively large values, but either ISA or PCMCIA or
> an arbitrary MFD for relatively small values" is absolutely crazy.
>
> FWIW, there are resources you define in include/linux/mfd/wm831x/core.h
> that have values between 0x4000 and 0x8000, which is exactly the
> range occupied by PCI devices on my thinkpad. It's only a matter of
> time until someone puts conflicting devices into one machine.
>
> ? ? ? ?Arnd

Even we append a new IORESOURCE type. We still meet similar issue. So
it means that we can't use any IORESOURCE for this kind of i2c usage. Is
it right?

Regards
Haojian
