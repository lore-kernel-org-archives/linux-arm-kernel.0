From: joe@perches.com (Joe Perches)
Date: Tue, 15 May 2012 16:08:34 -0700
Subject: [PATCH V2] CS89x0 : Use ioread16/iowrite16 on all platforms
In-Reply-To: <20120515223711.GA12674@electric-eye.fr.zoreil.com>
References: <1337112906-31033-1-git-send-email-jaccon.bastiaansen@gmail.com>
 <20120515223711.GA12674@electric-eye.fr.zoreil.com>
Message-ID: <1337123314.7050.26.camel@joe2Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-05-16 at 00:37 +0200, Francois Romieu wrote:
> Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com> :
> [...]
> > diff --git a/drivers/net/ethernet/cirrus/cs89x0.c b/drivers/net/ethernet/cirrus/cs89x0.c
> > index b9406cb..8081ad5 100644
> > --- a/drivers/net/ethernet/cirrus/cs89x0.c
> > +++ b/drivers/net/ethernet/cirrus/cs89x0.c
> [...]
> > -static int cs89x0_probe1(struct net_device *dev, unsigned long ioaddr, int modular);
> > +static int cs89x0_probe1(struct net_device *dev,
> > +			 void __iomem *ioaddr,
> > +			 int modular);
> > +static int cs89x0_probe1(struct net_device *dev, void __iomem *ioaddr,
> > +			 int modular);
> 
> s/int/bool/ maybe.
> 
> You may skip the name of the parameters.

Better would be to not duplicate the prototype
and better still would be to reorder the code to
avoid the prototype altogether.
