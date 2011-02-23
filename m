From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 22 Feb 2011 21:37:28 -0500 (EST)
Subject: [PATCH] msm: add single-wire serial bus interface (SSBI) driver
In-Reply-To: <8ya62sbli3z.fsf@huya.qualcomm.com>
References: <1297989299-27320-1-git-send-email-kheitke@codeaurora.org>
	<1297989432.9680.50.camel@c-dwalke-linux.qualcomm.com>
	<4D5DC289.1090004@codeaurora.org>
	<1298054771.17758.1.camel@c-dwalke-linux.qualcomm.com>
	<AANLkTi=0Pxg09x8DdVDVy9Ur7r1dgB+4LM3q0hM4_8Rg@mail.gmail.com>
	<1298419839.17118.5.camel@m0nster> <8ya62sbli3z.fsf@huya.qualcomm.com>
Message-ID: <alpine.LFD.2.00.1102222049410.22028@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Feb 2011, David Brown wrote:

> On Tue, Feb 22 2011, Daniel Walker wrote:
> 
> > On Tue, 2011-02-22 at 12:47 -0800, Dima Zavin wrote:
> >
> >> What is the problem leaving it under arch/arm/mach-msm?
> >
> > Because it's a driver.
> 
> There are a lot of other drivers currently under various arch
> subsystems.  

And they are wrong.  Probably because of some historical reasons.

> I'm not sure if a driver that is specific to only one arch
> has a strong reason to be elsewhere in the kernel.

You'll find plenty of examples for that, far more than drivers in arch 
specific directories.

> If there was a possibility of there being other devices that used 
> SSBI, it might make sense to put it elsewhere.  But, as far as I know, 
> this device is only found on MSM chips.

That doesn't matter.

The main reasoning is that Linux has no stable internal API by design. 
When large scale driver API changes happen, it is the responsibility of 
the person doing that change to also fix up all the in-tree users of 
that API.  And it is far more trouble for that person who probably has 
no knowledge about msm to go and hunt for all scattered drivers 
throughout the tree than it is for you to remember that all your drivers 
are under linux/drivers/.

And if someone else comes up with a SSBI interface, then it will be much 
easier to notice the already existing driver if it is in the driver 
directory rather than somewhere else in some unrelated (from that 
person's pov) obscure directory.

This was discussed in the past already.  I would have liked to provide a 
link to some archived discussions (they do exist) but I can't find them 
at the moment.

> It seems kind of unusual to create an entirely new directory under
> drivers to hold what will only ever be a single driver.

Well, a couple examples exist already: drivers/dca, drivers/nfc, 
drivers/sn, drivers/tc, drivers/vlynq, etc.  And if you expect to have 
more oddball msm drivers then you can create a drivers/msm directory, 
similar to the existing drivers/macintosh, drivers/parisc, drivers/s390, 
drivers/sh, drivers/video/omap, drivers/video/omap2, etc.


Nicolas
