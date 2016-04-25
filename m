From: pramod.kumar@broadcom.com (Pramod Kumar)
Date: Mon, 25 Apr 2016 09:39:38 +0530
Subject: [PATCH 1/6] bus: Add shared MDIO bus framework
In-Reply-To: <20160424.141806.786009616301278103.davem@davemloft.net>
References: <1461230323-27891-1-git-send-email-pramod.kumar@broadcom.com>
 <1461230323-27891-2-git-send-email-pramod.kumar@broadcom.com>
 <20160424.141806.786009616301278103.davem@davemloft.net>
Message-ID: <5876c521a46dbb4bd1b0c22bc64ec1a5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Thanks for providing input over the patch.  Will address the comment as
described below.

> -----Original Message-----
> From: David Miller [mailto:davem at davemloft.net]
> Sent: 24 April 2016 23:48
> To: pramod.kumar at broadcom.com
> Cc: robh+dt at kernel.org; catalin.marinas at arm.com; will.deacon at arm.com;
> yamada.masahiro at socionext.com; wens at csie.org; bcm-kernel-feedback-
> list at broadcom.com; pawel.moll at arm.com; mark.rutland at arm.com;
> arnd at arndb.de; suzuki.poulose at arm.com; punit.agrawal at arm.com;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; netdev at vger.kernel.org; anup.patel at broadcom.com
> Subject: Re: [PATCH 1/6] bus: Add shared MDIO bus framework
>
> From: Pramod Kumar <pramod.kumar@broadcom.com>
> Date: Thu, 21 Apr 2016 14:48:38 +0530
>
> > +struct shared_mdio_master *shared_mdio_alloc_master(struct device
> *parent,
> > +						    struct device_node
*node)
> > +{
> > +	int ret = 0;
> > +	struct shared_mdio_master *master;
>
> Always order local variable declarations in reverse christmas tree
(longest to
> shortest line) order.
>

Sure. Next patch will address this.

> > +static int shared_mdio_driver_probe(struct device *dev) {
> > +	int rc;
> > +	struct shared_mdio_master *master = to_shared_mdio_master(dev);
> > +	struct shared_mdio_driver *drv =
to_shared_mdio_driver(dev->driver);
>
> Likewise.

Sure.

> Please audit your entire submission for this issue.

Sure. I'll audit the entire patch set for above issue.

Regards,
Pramod
