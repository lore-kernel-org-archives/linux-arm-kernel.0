From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 31 Dec 2009 12:27:28 +0000
Subject: Ethernet / SD Boot
In-Reply-To: <4B3B579E.8030105@warmcat.com>
References: <20091228192244.GD14799@sirena.org.uk>
	<4B390AC3.2060702@warmcat.com>
	<20091228202123.GA16524@sirena.org.uk>
	<4B391941.6000906@warmcat.com>
	<20091228224435.GA23617@sirena.org.uk>
	<4B39D439.9070909@warmcat.com>
	<20091229123348.GB5784@opensource.wolfsonmicro.com>
	<4B39FB2C.4010608@warmcat.com>
	<20091230131559.GA369@opensource.wolfsonmicro.com>
	<4B3B579E.8030105@warmcat.com>
Message-ID: <20091231122727.GA5613@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 30, 2009 at 01:37:34PM +0000, Andy Green wrote:

> If you have JTAG gear that works reliably (I never had much luck
> with OpenOCD, I only ever got it to work with the OM debug board
> with one specific build of a library, not the latest one either).  I
> have a Wind River JTAG dongle here that only works on Fedora 6 or
> something, it's not really workable here or at a factory to set up
> VMs to please this piece of test gear.  I guess you have better luck
> depending on JTAG than I have, it certainly creates a burden to use
> it in my experience.

The one I've had the most positive experience with was the BDI2000 - no
host software required, it's controlled over the network via telnet (and
possibly other things now) for non-debugging activity and provides a GDB
stub for debugging.  Like everything else there are plenty of rubbish
products out there.

> >Assuming the hardware can cope with it, and there's component cost,
> >board area and mechanical concerns to address before it gets designed
> >in.  There are a lot of systems where it would be useful but there's
> >drawbacks you have to bear in mind when pushing it.

> I don't really regard those as drawbacks.

> Component cost is just the connector and four pullups, I guess it's $0.70.

That 70 cents does rather add up once you start to ship in volume, even
a fraction of that would.

> Yeah you need to make the uSD connector accessible if you remove a
> cover, that's generally not hard.

In some form factors.  In others it's very problematic.

> CPUs in the class where it is useful (ARM11+) all tend to have one
> or more SD peripheral unit on the CPU already, so that's for free.

Assuming you've not used all the pins for something else, which is again
a problem for some classes of device.
