From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Apr 2014 08:04:14 +0100
Subject: [PATCH v5 5/8 fix] mtd: m25p80: use the SPI nor framework
In-Reply-To: <20140411003203.GC3837@localhost.localdomain>
References: <1393238262-8622-6-git-send-email-b32955@freescale.com>
 <1393574142-17234-1-git-send-email-b32955@freescale.com>
 <20140409213749.GH32070@ld-irv-0074>
 <20140410072509.GA24100@localhost>
 <20140410192902.GM32070@ld-irv-0074>
 <20140411003203.GC3837@localhost.localdomain>
Message-ID: <20140411070414.GA9801@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Apr 2014, Huang Shijie wrote:

> On Thu, Apr 10, 2014 at 12:29:02PM -0700, Brian Norris wrote:
> > > IMHO, we should create a patch or several patches to add the MTD_SPI_NOR
> > > to the defconfigs.
> > 
> > Yeah, I think that's best.
> I will create a patch when i back to office.
> Or you can create it yourself.
> 
> > 
> > > > Also, I think m25p80.c is no longer a "self-contained MTD device driver"
> > > > and should be moved under drivers/mtd/spi-nor/.
> > > If we move the m25p80.c to the drivers/mtd/spi-nor/, we also need to move
> > > other drivers too.
> > 
> > Which ones? I think it only makes sense to move those that depend on the
> > same core code (i.e., spi-nor.c), or have a close relation to it (so
> > Lee's st_spi_fsm.c is a candidate).
> 
> yes, i mean the st_spi_fsm.c and other drivers which will use the
> spi-nor core code in the future.

+1 - happy with this.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
