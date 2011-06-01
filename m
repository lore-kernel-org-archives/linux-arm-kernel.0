From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 1 Jun 2011 10:46:00 -0600
Subject: [PATCH] gpio: ep93xx: move driver to drivers/gpio
In-Reply-To: <20110601082631.GC3660@n2100.arm.linux.org.uk>
References: <201105311249.30372.hartleys@visionengravers.com>
	<BANLkTimzWyhZ14ieo0SUfsn8SKp9cM_EBw@mail.gmail.com>
	<ADE657CA350FB648AAC2C43247A983F001F381FC4A77@AUSP01VMBX24.collaborationhost.net>
	<BANLkTikp=Pbh+r3od7fKRP4A7wJrC-i25A@mail.gmail.com>
	<20110601082631.GC3660@n2100.arm.linux.org.uk>
Message-ID: <BANLkTi=0_t6+=8Ww+a+jX4SR5ni9KQnYqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 1, 2011 at 2:26 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, May 31, 2011 at 05:28:26PM -0600, Grant Likely wrote:
>> > [...]Should I change this to:
>> >
>> > +config GPIO_EP93XX
>> > + ? ? ? bool
>> > + ? ? ? depends on ARCH_EP93XX
>> > + ? ? ? default y
>> >
>> > Or like the Samsung drivers, without the visibility:
>> >
>> > +config GPIO_EP93XX
>> > + ? ? ? bool
>> > + ? ? ? depends on ARM
>> > + ? ? ? default y if ARCH_EP93XX
>>
>> I like the former.
>
> Even better is:
>
> config GPIO_EP93XX
> ? ? ? ?def_bool y
> ? ? ? ?depends on ARCH_EP93XX

Yup.

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
