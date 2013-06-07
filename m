From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 7 Jun 2013 10:32:49 -0400
Subject: [PATCH 2/5] arm: preserve ATAGS in /chosen/atags in the Device
 Tree
In-Reply-To: <20130607112101.2cedbc5f@skate>
References: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370414409-29991-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130606142851.6dd17cad@skate>
 <alpine.LFD.2.03.1306061253430.18597@syhkavp.arg>
 <20130607112101.2cedbc5f@skate>
Message-ID: <20130607143249.GR23859@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 11:21:01AM +0200, Thomas Petazzoni wrote:
> Dear Nicolas Pitre,
> 
> On Thu, 6 Jun 2013 13:27:38 -0400 (EDT), Nicolas Pitre wrote:
> 
> > > I'd be interested to hear your opinion about the below proposal, that
> > > allows platform-specific code to do its own parsing of ATAGS
> > > information, without cluttering the generic code.
> > 
> > Personally, I don't like it.
> > 
> > Not that the code itself is extremely ugly.  That is not the point.
> > 
> > This opens the door to laziness on the part of bootloader authors and 
> > system integrators which will simply (ab)use this mechanism as this 
> > allows them to sit on what they already have instead of making the extra 
> > mile to bring things into conformance.  And overtime this means 
> > maintenance nightmare for us.
> > 
> > I'm sorry but the only leverage we have to create some incentive for 
> > people to do the right thing is exactly to say no to such kind of 
> > accommodation.
> > 
> > If Marvell has done things improperly in the past, it is for them to pay 
> > the maintenance cost of their choices, not for mainline to carry them.
> 
> Well, I don't think what you say here is really fair. Before the DT was
> in place, unless I missed it, there was no standard way of letting the
> bootloader pass MAC addresses to the kernel. And Marvell's development
> on those Armada 370/XP platforms predates the introduction of the
> Device Tree in the Linux kernel (the code we have originally been give
> was a 2.6.3x), so it's really not their fault to not have a DT-capable
> bootloader at this point.

To be accurate, I think Nico is referring to the fact that Marvell
assigned their own ATAG without going through Russell.

However, just like mach-types, are we assigning any new atags?  Can we
consider them deprecated?  If so, that changes the game.  Then what
Thomas is proposing is a "legacy compatibility" patch, as opposed to a
hole vendors can use to do their own thing.

We could add Arnd's suggestion of a time bomb on the common code in
atags_to_fdt.c to prevent mis-use.

I'm not 100% convinced of this, and I actually tend to agree with Nico
here, but I'd also like to find a workable solution.

thx,

Jason.
