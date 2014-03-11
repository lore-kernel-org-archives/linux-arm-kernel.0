From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 11 Mar 2014 09:50:22 +0100
Subject: [PATCH v4 6/7] DMA: sun6i: Add driver for the Allwinner A31 DMA
 controller
In-Reply-To: <5055473.2ZTHMWo41J@wuerfel>
References: <1394462512-11620-1-git-send-email-maxime.ripard@free-electrons.com>
 <2475487.axlvKsBQ0c@wuerfel> <20140310165156.GI2815@lukather>
 <5055473.2ZTHMWo41J@wuerfel>
Message-ID: <20140311085022.GK2815@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 10, 2014 at 06:57:00PM +0100, Arnd Bergmann wrote:
> On Monday 10 March 2014 17:51:56 Maxime Ripard wrote:
> > > 
> > > Neither "pll6" nor "ahb1_mux" are listed in the DT binding. Also, why
> > > is it the driver's business to set the parent?
> > 
> > Those are global clocks, so it's not really part pof the driver
> > binding itself. But I can add them.
> 
> No better don't then. Can you change the clk_get() call to pass
> NULL as the device pointer to clarify this in the source though?

Ok.
 
> > About the reparenting itself, other devices are actually fine having
> > any parent they want, only the DMA is picky about it (at least, from
> > what we know), so it made sense to me to put it into the driver
> > itself. Where would you put it?
> 
> Maybe Mike Turquette has an idea. We have in the past discussed
> about cases where you want the default clock setting to be part
> of the clock provider in some property. Could that work here?

You mean in the DT? I guess it would yes.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140311/58591b9c/attachment.sig>
