From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 12 Mar 2012 12:10:04 -0400
Subject: [PATCH 1/2] ARM: kirkwood: Basic support for DNS-320 and DNS-325
In-Reply-To: <201203120811.23137.arnd@arndb.de>
References: <1331476406-9844-1-git-send-email-jm@lentin.co.uk>
 <201203111746.09757.arnd@arndb.de>
 <20120312031751.GY5050@titan.lakedaemon.net>
 <201203120811.23137.arnd@arndb.de>
Message-ID: <20120312161004.GB5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 08:11:22AM +0000, Arnd Bergmann wrote:
> On Monday 12 March 2012, Jason Cooper wrote:
> > > Or even use the ranges property to remap everything into
> > > a simpler address range:
> > > 
> > >       ocp at f1000000 {
> > >               compatible = "simple-bus";
> > >               ranges = <0 0xf1000000 0x1000000>;
> > >               #address-cells = 1;
> > >               #size-cells = 1;
> > > 
> > >               serial at 12000 {
> > >                       reg = <0x12000 0x100>;
> > >                       ...
> > >               };
> > > 
> > >               ...
> > >       };
> > 
> > Okay, that's pretty slick.  The wdt and intc are at 0xfed00000, is that
> > another ocp bus?  Or, am I missing something?
> 
> If they are on those addresses, yes. If you have a data sheet, you should
> look at what the buses are named there, "ocp" was just an example and I
> took that name from the <mach/kirkwood.h> file.
> 
> It does seem though that the 0xfed00000 address is where Linux maps
> the same 0xf1000000 range in its own virtual address space, so it's
> not something that should appear in the device tree.

Okay, that's what smelled funny.  wdt and intc both only have registers
in virtual address space defined.  Can I assume they map like everything
else to corresponding physical addresses?

eg wdt at fed20300 -> wdt at f1020300 ?

thx,

Jason.
