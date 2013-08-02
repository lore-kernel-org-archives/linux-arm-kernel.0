From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Aug 2013 01:39:23 -0700
Subject: [Ksummit-2013-discuss] [ATTEND] [ARM ATTEND] kernel data bloat
 and how to avoid it
In-Reply-To: <20130802081103.GA3042@kroah.com>
References: <20130731073802.GT7656@atomide.com>
 <20130731123351.GA30474@kroah.com>
 <20130802075352.GY7656@atomide.com>
 <20130802081103.GA3042@kroah.com>
Message-ID: <20130802083923.GD7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Greg KH <greg@kroah.com> [130802 01:16]:
> On Fri, Aug 02, 2013 at 12:53:53AM -0700, Tony Lindgren wrote:
> > * Greg KH <greg@kroah.com> [130731 05:39]:
> > > On Wed, Jul 31, 2013 at 12:38:03AM -0700, Tony Lindgren wrote:
> > > > Hi all,
> > > > 
> > > > Probably the biggest kernel data bloat issue is in the ARM land, but
> > > > it also seems that it's becoming a Linux generic issue too, so I
> > > > guess it could be discussed in either context.
> > > 
> > > Why is it specific to ARM?  What is so unique to ARM that causes it to
> > > "bloat"?
> > 
> > I think it has so far showed up on ARM because of no discoverable busses,
> > but chances are it will be more of a generic problem.
> > 
> > > And what exactly do you mean by "bloat"?
> > 
> > Stuffing data to kernel that should not be in the kernel at all. Or
> > if the data is needed by kernel, there should be only one set of the
> > data defined rather than multiple copies of the data built into the
> > kernel for each SoC or driver variant.
> > 
> > > > Basically the data bloat issue is there for the arch code and drivers
> > > > and may not show up initially until things have headed the wrong way for
> > > > too long.
> > > 
> > > What do you mean by this?  You seem to be very vague here.
> > 
> > People are unnecessarily defining registers in kernel for similar devices
> > over and over again for each new SoC at the arch level and now more and
> > more at the driver level.
> > 
> > One example of that are device tree based drivers that don't describe
> > the actual hardware, but instead have a binding that points to an index
> > of defined registers in the driver.
> 
> Ok, and exactly how much "larger" does something like this cost as a
> real number, and as a percentage of the size of the kernel?

Well one example has been making omap4 SoC booting device tree only, and
that has reduced the built in kernel data for pinmux, board support and
platform init code by something like 6000 lines, with patches posted to
reduce the clock related build in kernel data by about additional 1700
lines. Sure some of that has moved to live under drivers, but mostly defined
in the .dts files.

But I'm afraid quite a bit of stuff in general is now just moved to
drivers without dealing with the data issues properly. So I'm hoping
we could establish some guidelines on doing things that might help other
maintainers to catch and solve similar issues.

Regards,

Tony
