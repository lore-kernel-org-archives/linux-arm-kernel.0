From: marex@denx.de (Marek Vasut)
Date: Wed, 27 Nov 2013 10:32:13 +0100
Subject: [PATCH 2/4] mtd: spi-nor: add a new data structrue spi_nor{}
In-Reply-To: <52957690.60102@freescale.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA4EEF0@DBDE04.ent.ti.com>
 <52957690.60102@freescale.com>
Message-ID: <201311271032.13259.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Huang Shijie,

> ? 2013?11?26? 19:42, Gupta, Pekon ??:
> >> From: Huang Shijie [mailto:b32955 at freescale.com]
> > 
> > [...]
> > 
> >> +#define	MAX_CMD_SIZE		6
> >> +
> >> +enum read_type {
> >> +	M25P80_NORMAL = 0,
> >> +	M25P80_FAST,
> >> +	M25P80_QUAD,
> >> +};
> > 
> > Sorry. no 'M25P80' suffix here this is spi-nor.h :-)
> 
> ok. thanks. :)
> 
> >> +
> >> +struct spi_nor {
> >> +	struct mutex		lock;
> >> +	struct mtd_info		mtd;
> > 
> > mtd_info should not be present here. Rather it should be other way round
> > 'mtd_info->priv = (struct spi_nor *) spi_nor;
> 
> put the mtd here can make code simple,

The MTD API functions will pass you the struct mtd_info anyway, so you will need 
to implement mtdinfo_to_yourdriverdata() function, no need for duplication.

> do David/Brian have any comment about this?
> If all object to put the mtd here, i will change it.
> 
> >> +	struct device		*dev;
> > 
> > Again, spi_nor would be a MTD device, not a new type of device on its
> > own. Thus you should use, mtd_info->dev.
> 
> this dev pointer is not from the mtd_info->dev, it from the spi_device
> or other spi nor device .

So this is your own device pointer or ... what kind of device pointer?
[...]

Best regards,
Marek Vasut
