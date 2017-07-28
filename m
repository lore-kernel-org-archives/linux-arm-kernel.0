From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 27 Jul 2017 18:44:21 -0700
Subject: [PATCH net-next 04/18] net: mvpp2: move the mii configuration in
 the ndo_open path
In-Reply-To: <20170726161111.GG12049@lunn.ch>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-5-antoine.tenart@free-electrons.com>
 <20170726161111.GG12049@lunn.ch>
Message-ID: <20170728014421.GB24728@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Wed, Jul 26, 2017 at 06:11:11PM +0200, Andrew Lunn wrote:
> On Mon, Jul 24, 2017 at 03:48:34PM +0200, Antoine Tenart wrote:
> > This moves the mii configuration in the ndo_open path, to allow handling
> > different mii configurations later and to switch between these
> > configurations at runtime.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> > ---
> >  drivers/net/ethernet/marvell/mvpp2.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
> > index 6ffff929b22a..9d204ffb9b89 100644
> > --- a/drivers/net/ethernet/marvell/mvpp2.c
> > +++ b/drivers/net/ethernet/marvell/mvpp2.c
> > @@ -5862,6 +5862,7 @@ static void mvpp2_start_dev(struct mvpp2_port *port)
> >  	/* Enable interrupts on all CPUs */
> >  	mvpp2_interrupts_enable(port);
> >  
> > +	mvpp2_port_mii_set(port);
> 
> You probably should take a look at mvpp2_port_mii_set() and have it
> handle all PHY_INTERFACE_MODE_RGMII variants.

I'll have a look at these variants (and update the whole series).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170727/de69ef02/attachment.sig>
