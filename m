From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Nov 2009 11:38:41 +0000
Subject: [PATCH 09/19] drivers: serial: add support for Samsung S5PC110
	SoC uart
In-Reply-To: <20091119110827.GE9763@rakim.wolfsonmicro.main>
References: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
	<1258551194-16018-10-git-send-email-m.szyprowski@samsung.com>
	<1b68c6790911180614y355f656fs828177ecc845ec8e@mail.gmail.com>
	<20091118221345.GB4808@trinity.fluff.org>
	<1b68c6790911181844p3fb32525h11f79f942afb2d64@mail.gmail.com>
	<20091119103336.GB15460@sirena.org.uk>
	<1b68c6790911190305w33e777e3n1ed6b172d67f1639@mail.gmail.com>
	<20091119110827.GE9763@rakim.wolfsonmicro.main>
Message-ID: <20091119113841.GJ13376@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 11:08:27AM +0000, Mark Brown wrote:
> On Thu, Nov 19, 2009 at 08:05:29PM +0900, jassi brar wrote:
> > On Thu, Nov 19, 2009 at 7:33 PM, Mark Brown
> 
> > > This is going to set off warnings from a clock API point of view -
> > > passing clock names around in platform data is usually a sign that
> > > something is very wrong. ?Keeping the mapping inside the clock API
> > > (still controlled by the board driver but by telling the clock API that
> > > device X should use clock Y).
> 
> > no clock pointer needs to be passed, just a pointer to an array of _strings_
> > There is no need to even include any clock header in platform code
> > for the purpose.
> 
> Yes, that's what I was commenting on - like I say, passing clock names
> tends to set off the same alarm bells as passing a struct clk.  Like I
> say, the general model for this has been that the fixups will be done by
> having the machine code talk to the clock API ratehr than bouncing the
> data about the clock to use through the driver.

I'm not sure what you're commenting on precisely, but the Samsung code as
a whole doesn't use the clk API very well, and I suspect that is starting
to cause people to have to pass clock names around.

I've tried to persuade Ben to tidy this up and convert over to clkdev
before it becomes too big a problem, but I've had little success.  I
suspect it's now grown too big to be tackled sanely.
