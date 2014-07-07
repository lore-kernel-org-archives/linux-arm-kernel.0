From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Jul 2014 14:41:57 +0200
Subject: [PATCH v10 2/2] dmaengine: sun6i: Add driver for the Allwinner
 A31 DMA controller
In-Reply-To: <201407061722.01279.arnd@arndb.de>
References: <1404134454-25513-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140701124852.GB6064@leverpostej>
 <20140704075710.GN31996@lukather>
 <201407061722.01279.arnd@arndb.de>
Message-ID: <20140707124157.GA13423@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 06, 2014 at 05:22:00PM +0200, Arnd Bergmann wrote:
> On Friday 04 July 2014, Maxime Ripard wrote:
> > > > > It feels a little fragile to rely on the organisation of the clock tree
> > > > > and the naming thereof. If the IP block is ever reused on an SoC with a
> > > > > different clock tree layout then we have to handle things differently.
> > > > 
> > > > What do you suggest then?
> > > 
> > > I will admit that I don't have a better suggestion.
> > > 
> > > Without knowing which particular constraint on the mux parent clock we
> > > care about it's difficult to suggest anything useful.
> > 
> > Well, I first made it into the mach- directory, and then was told to
> > move it in the driver itself, so we're kind of running out of options
> > :)
> 
> How about having a property in the clock provider node that forces a
> specific value for the mux? I think that's generally the preferred solution
> for any clock settings that go beyond what an OS can be expected to figure
> out for itself.

Except that we don't really care about the parenting if the device
isn't going to be used, so putting this property on the clock provider
doesn't look that good. Plus, in the case where we have multiple
clocks defined in a single node, it wouldn't work that great.

However, I'm not convinced that it should be on the device node
either, because we could end up having conflicts between devices.

I don't know, some C code seems like the easier and more flexible
solution here.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140707/3ed290bb/attachment.sig>
