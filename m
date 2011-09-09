From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 9 Sep 2011 15:41:05 +0200
Subject: [PATCH v2 1/3] ARM: mx28evk: add platform data for saif
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F77223C8CB@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1315403858-9904-1-git-send-email-b29396@freescale.com>
	<1315403858-9904-2-git-send-email-b29396@freescale.com>
	<20110907181811.GX28816@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F77223C8CB@039-SN1MPN1-003.039d.mgd.msft.net>
Message-ID: <20110909134105.GT1912@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > +static unsigned int saif_clkmux;

Can't we just read the register in get_master and spare the static
variable?

> > and is it intended that if you do:
> > 
> > 	mxs_saif_clkmux_select(1);
> > 	mxs_saif_clkmux_select(2);
> > 
> > the SAIF_CLKMUX_SEL bitfield ends up being 3?
> Yes, it ends up being 3.

Needs to be fixed, of course. The function will need locking then.

> > >  extern const struct mxs_saif_data mx28_saif_data[] __initconst;
> > > -#define mx28_add_saif(id)
> > mxs_add_saif(&mx28_saif_data[id])
> > > +#define mx28_add_saif(id, pdata) \
> > > +	mxs_add_saif(&mx28_saif_data[id], pdata)
> > should it be a seperate patch to add pdata for saif devices?
> How do you suggest to separate?
> All changes are mainly to add saif pdata.
> You mean to move DIGCTL related saif pdata function to another patch?

I think he meant one patch for adding the functions in clock-mx28.c and
one patch to use the stuff when adding the pdata. Uwe?

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110909/76649b9c/attachment.sig>
