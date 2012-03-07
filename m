From: jason@lakedaemon.net (Jason)
Date: Wed, 7 Mar 2012 13:37:05 -0500
Subject: [PATCH 06/14] ARM: kirkwood: convert uart0 to devicetree.
In-Reply-To: <201203071831.31738.arnd@arndb.de>
References: <cover.1331090356.git.jason@lakedaemon.net>
 <80fb8cef577eee14364e95009f7a590fd9056ee3.1331090356.git.jason@lakedaemon.net>
 <201203071831.31738.arnd@arndb.de>
Message-ID: <20120307183705.GC5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 06:31:31PM +0000, Arnd Bergmann wrote:
> On Wednesday 07 March 2012, Jason Cooper wrote:
> > +       serial at f1012000 {
> > +               compatible = "ns16550a";
> > +               reg = <0xf1012000 0xff>;
> > +               reg-shift = <2>;
> > +               interrupts = <33>;
> > +               clock-frequency = <200000000>;
> > +       };
> 
> I just noticed that the length here should be inclusive, i.e. 0x100 not 0xff.
> This is different from the way we define resources in Linux.

I was maintaining form with plat-orion/common.c:66 (0xff)  I'll fix it
to inclusive.

thx,

Jason.
