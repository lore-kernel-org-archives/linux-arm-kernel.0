From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 27 Jul 2017 18:50:33 -0700
Subject: [PATCH net-next 08/18] net: mvpp2: make the phy optional
In-Reply-To: <20170726162000.GJ12049@lunn.ch>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-9-antoine.tenart@free-electrons.com>
 <20170726162000.GJ12049@lunn.ch>
Message-ID: <20170728015033.GD24728@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Wed, Jul 26, 2017 at 06:20:00PM +0200, Andrew Lunn wrote:
> On Mon, Jul 24, 2017 at 03:48:38PM +0200, Antoine Tenart wrote:
> > SFP ports do not necessarily need to have an Ethernet PHY between the
> > SoC and the actual physical port. However, the driver currently makes
> > the "phy" property mandatory, contrary to what is stated in the Device
> > Tree binding.
> > 
> > To allow handling the PPv2 controller on those boards, this patch makes
> > the PHY optional, and aligns the PPv2 driver on its device tree
> > documentation.
> 
> It is an architectural question...
> 
> but with the boards i have with an SFF port, i actually use a
> fixed-phy to represent the SFF. Then nothing special is needed.

I was not aware of the fixed-phy, that might work for us here.
Thanks for the hint!

> Also, Russell King posted his phylink patches. Once accepted, you are
> going to want to re-write some of this to make use of that code.

And there's that as well.

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170727/349f36fb/attachment.sig>
