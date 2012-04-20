From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 20 Apr 2012 11:11:48 +0200
Subject: [PATCH v4 2/2] MTD: AT91: Update atmel_nand_data to support PMECC
In-Reply-To: <A92DB5DF46DBC241980A99BFD8A00AEE0F62D6EE@penmbx01>
References: <1334906788-18704-1-git-send-email-hong.xu@atmel.com>
 <1334906788-18704-2-git-send-email-hong.xu@atmel.com>
 <20120420082729.GY16641@game.jcrosoft.org>
 <A92DB5DF46DBC241980A99BFD8A00AEE0F62D6EE@penmbx01>
Message-ID: <20120420091148.GZ16641@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:24 Fri 20 Apr     , Xu, Hong wrote:
> 
> 
> > -----Original Message-----
> > From: Jean-Christophe PLAGNIOL-VILLARD [mailto:plagnioj at jcrosoft.com]
> > Sent: Friday, April 20, 2012 4:27 PM
> > To: Xu, Hong
> > Cc: linux-mtd at lists.infradead.org; linux-arm-kernel at lists.infradead.org;
> > dedekind1 at gmail.com; Ferre, Nicolas
> > Subject: Re: [PATCH v4 2/2] MTD: AT91: Update atmel_nand_data to support PMECC
> > 
> > On 15:26 Fri 20 Apr     , Hong Xu wrote:
> > > Added two items,
> > > * correction_cap: PMECC correction capability
> > > * sector_size:    Sector size for PMECC
> > >
> > > Signed-off-by: Hong Xu <hong.xu@atmel.com>
> > > ---
> > >  include/linux/platform_data/atmel.h |    2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/include/linux/platform_data/atmel.h
> > b/include/linux/platform_data/atmel.h
> > > index b0f2c56..4d9bfd5 100644
> > > --- a/include/linux/platform_data/atmel.h
> > > +++ b/include/linux/platform_data/atmel.h
> > > @@ -20,6 +20,8 @@ struct atmel_nand_data {
> > >  	u8		bus_width_16;		/* buswidth is 16 bit */
> > >  	u8		ecc_mode;		/* ecc mode */
> > >  	u8		on_flash_bbt;		/* bbt on flash */
> > > +	u8		correction_cap;		/* PMECC capability */
> > > +	u16		sector_size;		/* Sector size for PMECC */
> > as this only used by DT
> > no need to expose it
> > 
> 
> OK, we could put those into struct Atmel_nand_host. But this means PMECC will totally rely on DT.
yes as none of the non dt-only soc use it

Best Regards,
J.
