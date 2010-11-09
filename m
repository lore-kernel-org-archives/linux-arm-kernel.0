From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 9 Nov 2010 14:02:13 +0100
Subject: [PATCH 6/6 v3] ARM: Add support for the display controllers in
	VT8500 and WM8505
In-Reply-To: <20101109110407.GE2869@n2100.arm.linux.org.uk>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<1289147348-31969-6-git-send-email-alchark@gmail.com>
	<20101108041721.GA11605@linux-sh.org>
	<20101108141407.GA25739@alchark-u3s.lan>
	<20101108204315.GA12050@linux-sh.org>
	<20101109103312.GA2869@n2100.arm.linux.org.uk>
	<20101109105144.GA22389@linux-sh.org>
	<20101109110407.GE2869@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinWNoGJoDu6Ok8Ni5OuAXN29H7Bd3YMyUq6qfFq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 9, 2010 at 12:04, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 09, 2010 at 07:51:45PM +0900, Paul Mundt wrote:
>> On Tue, Nov 09, 2010 at 10:33:12AM +0000, Russell King - ARM Linux wrote:
>> > On Tue, Nov 09, 2010 at 05:43:16AM +0900, Paul Mundt wrote:
>> > > > diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
>> > > > new file mode 100644
>> > > > index 0000000..640d8a3
>> > > > --- /dev/null
>> > > > +++ b/drivers/video/vt8500lcdfb.c
>> > > > +#include <asm/irq.h>
>> > > > +
>> > > linux/irq.h is preferred here.
>> >
>> > I assume you've read the comment at the top of linux/irq.h ?
>>
>> I had forgotten about that. This comment predates git, so I'm unaware of
>> what the context is, could you elaborate on it?
>
> It's from a time when we didn't have generic irq (and as I understand,
> generic irq is still optional.)
>
> When you didn't have generic irq support for an arch, having drivers
> include linux/irq.h resulted in build errors, caused by nothing more
> than "use linux/foo.h rather than asm/foo.h" - as those architectures
> won't provide an asm/hw_irq.h.
>
> It looks to me like the only arch in the kernel which doesn't support
> generic irq is sh.

IIRC, m68k, sparc32, and s390.

Gr{oetje,eeting}s,

? ? ? ? ? ? ? ? ? ? ? ? Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
? ? ? ? ? ? ? ? ? ? ? ? ? ?? ?? -- Linus Torvalds
