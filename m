From: b32955@freescale.com (Huang Shijie)
Date: Thu, 10 Apr 2014 15:25:11 +0800
Subject: [PATCH v5 5/8 fix] mtd: m25p80: use the SPI nor framework
In-Reply-To: <20140409213749.GH32070@ld-irv-0074>
References: <1393238262-8622-6-git-send-email-b32955@freescale.com>
 <1393574142-17234-1-git-send-email-b32955@freescale.com>
 <20140409213749.GH32070@ld-irv-0074>
Message-ID: <20140410072509.GA24100@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 02:37:49PM -0700, Brian Norris wrote:
> >  config MTD_M25P80
> >  	tristate "Support most SPI Flash chips (AT26DF, M25P, W25X, ...)"
> > -	depends on SPI_MASTER
> > +	depends on SPI_MASTER && MTD_SPI_NOR_BASE
> >  	help
> >  	  This enables access to most modern SPI flash chips, used for
> >  	  program and data storage.   Series supported include Atmel AT26DF,
> 
> Now that M25P80 depends on MTD_SPI_NOR_BASE (which I proposed to rename
> to MTD_SPI_NOR a few hours ago), shouldn't we be updating everybody's
> defconfigs? As it stands, the defconfigs that use M25P80 will just drop
> it silently when built.
> 
> And if so, I'm not sure how this should be handled. Should defconfig
> patches be sent to their respective arch maintainers?

IMHO, we should create a patch or several patches to add the MTD_SPI_NOR
to the defconfigs.

Another method is to select the MTD_SPI_NOR which we enable the MTD.

> 
> Also, I think m25p80.c is no longer a "self-contained MTD device driver"
> and should be moved under drivers/mtd/spi-nor/.
If we move the m25p80.c to the drivers/mtd/spi-nor/, we also need to move
other drivers too.

thanks
Huang Shijie
