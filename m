From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 29 Aug 2016 15:46:14 +0000
Subject: Older hisilicon chipsets
In-Reply-To: <7850061.5OOjP34nIO@wuerfel>
References: <7773f0e5-d045-1e93-529b-74a601467ed1@gmail.com>
 <20160827150457.GM10637@io.lakedaemon.net>
 <ec3ec22f-f05e-aaec-8e9a-bfc0565b9e9d@gmail.com>
 <7850061.5OOjP34nIO@wuerfel>
Message-ID: <20160829154614.GP10637@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 12:54:15PM +0200, Arnd Bergmann wrote:
> On Saturday, August 27, 2016 1:53:25 PM CEST Marty Plummer wrote:
> > On 08/27/2016 10:04 AM, Jason Cooper wrote:
...
> > > Ideally, most of it will be a devicetree.  Assuming we have code for the
> > > SoC and associated drivers.
> > > 
> > Yes, I've been doing some work on that already, but as I've said, unsure
> > where one should/would insert all these different things.
> 
> start with getting the serial console working. debug_ll is useful for
> early bringup and should only need a patch to arch/arm/Kconfig.debug.

It looks like the other hisi board we have in the tree uses arm,pl011
for the serial ports.  Sometimes, a vendor will stick with an IP block
across multiple SoCs.  It's worth trying a minimal mainline kernel with
a minimal dts file and the serial node.  If that works, then everything
else is a lot easier. :-)

Since you stated on irc that you have some form of documentation, then
that should go a long way towards mapping uart0 to a register address.

> Later you would typically use earlycon (using a stdout-path property
> in DT to point to the UART and configuration). The approximate order
> in which you need other drivers is:
> 
> * drivers/irqchip (often a standard VIC or GIC)

the hip04 is heavily based on the ARM GIC, which just about everyone
uses.  You may get lucky here.  You're working with an older SoC, so
they might've just used the stock GIC and only branched out later.  Or,
worst case, they started with some in-house one-off and the hip04 is them
working towards using a vanilla GIC.

The rest we can worry about later.

thx,

Jason.
