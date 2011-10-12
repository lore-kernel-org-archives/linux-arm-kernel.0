From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 12 Oct 2011 15:42:52 +0100
Subject: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
In-Reply-To: <201110111724.48069.arnd@arndb.de>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<201110111617.52061.arnd@arndb.de>
	<20111011144005.GI3471@opensource.wolfsonmicro.com>
	<201110111724.48069.arnd@arndb.de>
Message-ID: <20111012144251.GM3647@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 05:24:47PM +0200, Arnd Bergmann wrote:
> On Tuesday 11 October 2011, Mark Brown wrote:

> > I'm not sure that IIO isn't the kernel subsystem we're looking for here
> > - as I keep saying when this comes up it's just representing bare DACs
> > and ADCs pretty directly which looks like a generic subsystem to me.

> Possible, yes. Until now, IIO is a subsystem for user-level access
> not for kernel access though, so it's not the right place yet.
> If we decide to let IIO handle all ADC input, do you think it would
> also be the right place to do PWM output, rather than having a
> separate subsystem for that?

Off the top of my head I'd expect PWM to be a separate thing which could
optionally synthesize stuff onto an IIO device (bitbanging the PWM
essentially).  The specialized PWM stuff tends to be "output this steady
state for an indefinite period" type interface rather than "here's a
batch of samples, output them".
