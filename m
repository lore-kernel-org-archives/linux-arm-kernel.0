From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Apr 2011 00:33:13 -0700
Subject: Status of arch/arm in linux-next
In-Reply-To: <201104191616.01647.arnd@arndb.de>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<BANLkTikVfdVQuR_nJZnra7Bo=CQgOfS5Zg@mail.gmail.com>
	<20110415062643.GB12272@atomide.com>
	<201104191616.01647.arnd@arndb.de>
Message-ID: <20110420073313.GB28679@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [110419 07:13]:
> On Friday 15 April 2011, Tony Lindgren wrote:
> > > drivers/platform/arm/ux500/*
> > > include/linux/platform/arm/ux500/*
> > > 
> > > Are any of these generally speaking good ideas?
> > 
> > Or maybe drivers/arm?
> > 
> > Anyways, whatever can be done as loadable modules should be done
> > that way. That makes the life for distros much easier ;)
> 
> drivers/arm would just become the next pile of crap if we start that,
> like drivers/misc is starting to look now.
> 
> There are more things that I think should become subsystems
> for themselves, with a proper maintainer, rather than bits
> that simply get copied across all platforms.

Sure that sounds good to me.
 
> ACPI does a lot of things (unfortunately), and I did not get the impression
> that prcmu does the one part we really need, which is complete enumeration
> of all devices. If it did that, it should become a bus_type and replace
> the hardcoded sets of platform devices.

Right, for most SoCs there is no such thing as enumeration of devices.
But passing that information in device tree format from the bootloader 
should sort that issue.

For omaps we have the hwmod bus abstraction for platform bus that could
be made generic potentially. Needs to be converted to use DT data first
though..

Tony
