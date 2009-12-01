From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 1 Dec 2009 13:32:03 +0100
Subject: [PATCH] ARM: gta02: Add gpio bank B quirk for hardware
	revision 5 and earlier
In-Reply-To: <20091130185613.GA6289@shareable.org>
References: <1259377532-8012-1-git-send-email-lars@metafoo.de>
	<1259377532-8012-2-git-send-email-lars@metafoo.de>
	<1259377532-8012-3-git-send-email-lars@metafoo.de>
	<1259377532-8012-4-git-send-email-lars@metafoo.de>
	<1259377532-8012-5-git-send-email-lars@metafoo.de>
	<20091129083425.GB1530@ucw.cz> <4B125373.9020505@metafoo.de>
	<20091130123141.GH13328@elf.ucw.cz>
	<20091130185613.GA6289@shareable.org>
Message-ID: <20091201123203.GB1982@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2009-11-30 18:56:13, Jamie Lokier wrote:
> Pavel Machek wrote:
> > On Sun 2009-11-29 11:56:51, Lars-Peter Clausen wrote:
> > > Pavel Machek wrote:
> > > > Hi!
> > > >
> > > >> On gta02 hardware revision 5 and earlier the basis resistors for
> > > >> transistors of the leds are missing and reading their gpio pin
> > > >> status will always return 0. So we have to shadow the led states
> > > >> in software. This is done by "hijacking" the gpio accessor
> > > >> functions for bank B.
> > > >
> > > > Should that be done in LED driver, instead? Pave
> > > Hi
> > > 
> > > Nope, that won't work. Every time a gpio on gpb is changed the leds
> > > will turn off. So we would have to ship a special version of each
> > > driver using a gpio pin form gpb. We certainly don't want to do that.
> > 
> > _Any_ GPIO pin change will turn off the LED? Wow, the hardware is
> > severely misdesigned then, ok. That means you do need to modify GPIO
> > :-(. You probably should state it clearly in the comments.
> 
> I don't think it's necessarily a hardware misdesign if you can't read
> back the value of output-only GPIOs, even though it's inconvenient.
> But from the sound of that comment, I'd worry about the current consumed :-)

Well, in such case... does it make sense to have flag such as
"GPIO_SHADOW", not special hacks? Or.... maybe we should be using
"shadow" state, always, as it should be faster, anyway?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
