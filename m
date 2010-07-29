From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Jul 2010 15:14:07 +0100
Subject: [PATCH 02/12] mmci: fix multi block transfers
In-Reply-To: <20100729135511.GD18923@n2100.arm.linux.org.uk>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
	<1277198267-10860-2-git-send-email-rabin.vincent@stericsson.com>
	<20100729131858.GB18923@n2100.arm.linux.org.uk>
	<000001cb2f22$65576150$300623f0$@tuckley@arm.com>
	<20100729133646.GC18923@n2100.arm.linux.org.uk>
	<000101cb2f23$e97d1280$bc773780$@tuckley@arm.com>
	<20100729135511.GD18923@n2100.arm.linux.org.uk>
Message-ID: <20100729141407.GF18923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 02:55:11PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 29, 2010 at 02:42:39PM +0100, Colin Tuckley wrote:
> > > However, I think this will make GPIO on Realview wrong - iirc, the card
> > > detection bits from PL061 are inverted.
> > 
> > See above.
> 
> I've no idea what the right thing on Realview is because the documentation
> is too poor in this area.  Although the Realview EB user manual gives you
> the GPIO block signals, it doesn't say what sense they are.
> 
> It looks to me from the hardware description diagrams, that the GPIO block
> is fed with an inverted signal from the socket card detect pin - which
> itself is active low.  That means the GPIO signal is in a positive logic
> state.
> 
> So I don't think that the "return !status;" is right even for the GPIO
> case.

Hmm.  Firstly, Versatile doesn't support reading the card detect via GPIO.

Secondly, my Realview hardware appears to have the GPIO card detect status
inverted - zero means card inserted, non-zero means card removed.  That's
contary to what the documentation suggests.

Confused.
