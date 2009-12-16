From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 16 Dec 2009 23:53:42 +0100
Subject: GPIO support for HTC Dream
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901FB10EB@mi8nycmail19.Mi8.com>
References: <4B1EB57D.6070408@bluewatersys.com>
	<20091208214658.GC4164@elf.ucw.cz>
	<4B1ECEEE.3000209@bluewatersys.com>
	<4B203575.6050407@bluewatersys.com>
	<20091210172458.GJ19454@elf.ucw.cz>
	<4B2150B7.3040207@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901FB0F92@mi8nycmail19.Mi8.com>
	<20091211221015.GB24456@elf.ucw.cz>
	<d6200be20912111440k427c5013j2b17191bcbae2d52@mail.gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE190901FB10EB@mi8nycmail19.Mi8.com>
Message-ID: <20091216225342.GH21102@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2009-12-11 18:12:35, H Hartley Sweeten wrote:
> On Friday, December 11, 2009 3:41 PM, Arve Hj?nnev?g wrote:
> 
> <snip>
> 
> >> Now, it will still need some cleanups -- I'm not sure if gpios are
> >> dream-specific or generic for whole msm.... I kind of assume they
> >> should be generic for msm. Google people, can you help?
> >
> > I'm not exactly sure what you are asking. Gpios in general are not
> > dream specific, the code in board-dream-gpio.c is. Some gpios (e.g.
> > DREAM_4_BALL_UP_0) are used for a dream specific function, but point
> > to a gpio that is generic to the msm architecture.
> 
> <snip>
> 

> >> +++ b/arch/arm/Kconfig
> >> + ? ? ? select GENERIC_GPIO
> >> + ? ? ? select ARCH_REQUIRE_GPIOLIB
> >
> > Please do not do this in a board specific change. You have not changed
> > the msm generic gpio support to use gpiolib.
> 
> Where is the msm tree located?  mach-msm in mainline doesn't appea to
> have _any_ gpio support.  

Right.

> Is Pavel's implementation generic enough to
> work with any msm based board?

I think so but I'm not sure; thats what I wanted google to
clarify. Lets keep it dream-specific for now...
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
