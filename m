From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 8 Dec 2010 16:43:33 +0100
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <1291819459.28378.64.camel@laptop>
References: <19697.8378.717761.236202@pilspetsen.it.uu.se>
	<19707.34405.791777.298955@pilspetsen.it.uu.se>
	<20101205131702.GE9138@n2100.arm.linux.org.uk>
	<20101205141921.GF9138@n2100.arm.linux.org.uk>
	<19707.47304.977978.297596@pilspetsen.it.uu.se>
	<20101205162151.GH9138@n2100.arm.linux.org.uk>
	<1291812015.28378.24.camel@laptop>
	<20101208125548.GA9777@n2100.arm.linux.org.uk>
	<1291817076.28378.28.camel@laptop>
	<20101208142814.GE9777@n2100.arm.linux.org.uk>
	<1291819459.28378.64.camel@laptop>
Message-ID: <AANLkTi=TYecfTGZ8iUDJPy+2HFTFYOjDEVxxE_1_Dvwf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/8 Peter Zijlstra <a.p.zijlstra@chello.nl>:

> Like said, John Stultz was already looking at doing something like that
> because there's a number of architectures suffering this same problem
> and they're all already using part of the clocksource infrastructure to
> implement the sched_clock() interface simply because they only have a
> single hardware resource.

I was in on that discussion and for the Ux500 this patch was the
outcome:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6488/1

It seems to work, mostly, it's based off Nico's orion code and
just tries to make everything as explicit as possible.

Uwe has also been onto it I think.

Yours,
Linus Walleij
