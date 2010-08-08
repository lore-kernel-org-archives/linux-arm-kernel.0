From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 8 Aug 2010 22:44:17 +0200
Subject: [PATCH 6/8] mxc_nand: fix correct_data function
In-Reply-To: <20100808061950.GB21128@jasper.tkos.co.il>
References: <1281102791-8089-1-git-send-email-s.hauer@pengutronix.de>
	<1281102791-8089-7-git-send-email-s.hauer@pengutronix.de>
	<20100808061950.GB21128@jasper.tkos.co.il>
Message-ID: <20100808204417.GB20065@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 08, 2010 at 09:19:50AM +0300, Baruch Siach wrote:
> Hi Sascha,
> 
> On Fri, Aug 06, 2010 at 03:53:09PM +0200, Sascha Hauer wrote:
> > The v2 controller has a totally different mechanism to check
> > whether the data we read had ecc errors or not. Implement this.
> > The mechanism in the v2 controller happens to be identical to
> > the v3 controller.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/mtd/nand/mxc_nand.c |   42 ++++++++++++++++++++++++++++++++++++++++--
> >  1 files changed, 40 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> > index 48b6dca..a6dc5a5 100644
> > --- a/drivers/mtd/nand/mxc_nand.c
> > +++ b/drivers/mtd/nand/mxc_nand.c
> > @@ -94,6 +94,7 @@ struct mxc_nand_host {
> >  	struct clk		*clk;
> >  	int			clk_act;
> >  	int			irq;
> > +	int			eccsize;
> 
> This new mxc_nand_host field doesn't get initialized in this patch, although 
> it is used in the .correct implementation. The next patch in this series 
> includes the eccsize initialization code. This might break bisect. Won't it be 
> safer to switch the order of these patches?

Ok, will fix.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
