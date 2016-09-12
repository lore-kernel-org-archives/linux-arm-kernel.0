From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 12 Sep 2016 20:18:28 +0200
Subject: [PATCH 4/9] mtd: nand: Add function to convert ONFI mode to
 data_interface
In-Reply-To: <20160912063511.flb3se54dy4itlru@pengutronix.de>
References: <1473422712-12359-1-git-send-email-s.hauer@pengutronix.de>
 <1473422712-12359-5-git-send-email-s.hauer@pengutronix.de>
 <20160909143522.6a3b6975@bbrezillon>
 <20160912063511.flb3se54dy4itlru@pengutronix.de>
Message-ID: <20160912201828.52c60232@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Sep 2016 08:35:11 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> On Fri, Sep 09, 2016 at 02:35:22PM +0200, Boris Brezillon wrote:
> > On Fri,  9 Sep 2016 14:05:07 +0200
> > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >   
> > > onfi_init_data_interface() initializes a data interface with
> > > values from a given ONFI mode.
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  drivers/mtd/nand/nand_timings.c | 16 ++++++++++++++++
> > >  include/linux/mtd/nand.h        |  2 ++
> > >  2 files changed, 18 insertions(+)
> > > 
> > > diff --git a/drivers/mtd/nand/nand_timings.c b/drivers/mtd/nand/nand_timings.c
> > > index 9af2ebc..ece4ff2 100644
> > > --- a/drivers/mtd/nand/nand_timings.c
> > > +++ b/drivers/mtd/nand/nand_timings.c
> > > @@ -269,3 +269,19 @@ const struct nand_sdr_timings *onfi_async_timing_mode_to_sdr_timings(int mode)
> > >  	return &onfi_sdr_timings[mode].timings.sdr;
> > >  }
> > >  EXPORT_SYMBOL(onfi_async_timing_mode_to_sdr_timings);
> > > +
> > > +/**
> > > + * onfi_init_data_interface - [NAND Interface] Initialize a data interface from
> > > + * given ONFI mode
> > > + * @iface: The data interface to be initialized
> > > + * @mode: The ONFI timing mode
> > > + */
> > > +int onfi_init_data_interface(struct nand_data_interface *iface, int mode)  
> > 
> > Can we choose a more future proof prototype (like the one I suggested)
> > for this function. Passing the nand_chip will later allow to extract
> > extended timings (tR, tPROG, tCCS, ...) from the param page, and
> > passing the interface type makes it compatible with DDR mode.  
> 
> Ok, will change as you suggested to:
> 
> int onfi_init_data_interface(struct nand_chip *chip,
>                              struct nand_data_interface *iface,
>                              enum nand_data_interface_type type,
>                              int timing_mode)
> 
> Before I send another round: Are the other patches ok?

Yes.
