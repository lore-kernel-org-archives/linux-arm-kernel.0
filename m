From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 16 Jan 2018 08:56:55 +1100
Subject: [PATCH 1/2 v2] ARM: dts: Add Aspeed SoC USB controllers to
 device-tree
In-Reply-To: <1516031982.5522.3.camel@aj.id.au>
References: <1515738064.31850.100.camel@kernel.crashing.org>
 <1516031982.5522.3.camel@aj.id.au>
Message-ID: <1516053415.31850.137.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-01-15 at 09:59 -0600, Andrew Jeffery wrote:
> > +             uhci: usb at 1e6b0000 {
> > +                     compatible = "aspeed,ast2400-uhci", "generic-uhci";
> > +                     reg = <0x1e6b0000 0x100>;
> > +                     interrupts = <14>;
> > +                     #ports = <3>;
> 
> I tried to find the documentation for the #ports property, but it seems
> to not exist. Couldn't find any users either, but maybe I didn't look
> broadly enough. It is tested for in drivers/usb/host/uhci-platform.c
> though, so I guess it's functional.

I added it to uhci-platform back when that was merged but forgot to
update the binding. I'll send a separate patch for that.

Cheers,
Ben.
