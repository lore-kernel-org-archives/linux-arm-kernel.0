From: B19295@freescale.com (Lin Tony-B19295)
Date: Mon, 15 Aug 2011 06:30:58 +0000
Subject: GPMI-NAND Status?
In-Reply-To: <20040.45443.810005.525431@ipc1.ka-ro>
References: <20110805135133.GA26981@pengutronix.de>
	<20110814081139.GD17063@parrot.com>
	<20040.45443.810005.525431@ipc1.ka-ro>
Message-ID: <97D3A72708D04647A5AC84A04996E5B5194B56@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Lothar Wa?mann
> Sent: Monday, August 15, 2011 1:41 PM
> To: Ivan Djelic
> Cc: Koen Beel; Wolfram Sang; Huang Shijie-B32955; linux-
> mtd at lists.infradead.org; Shawn Guo; linux-arm-kernel at lists.infradead.org
> Subject: Re: GPMI-NAND Status?
> 
> Hi,
> 
> Ivan Djelic writes:
> > On Fri, Aug 05, 2011 at 02:51:33PM +0100, Wolfram Sang wrote:
> > (...)
> > >
> > > problem overwriting all-0xff data in NAND [2]
> > > =============================================
> > >
> > > Although it occured only when writing JFFS2 images so far, this is a
> > > generic issue and needs to be fixed, right?
> > >
> > >
> > (...)
> > > [2]
> > > http://lists.infradead.org/pipermail/linux-mtd/2011-July/037104.html
> >
> > As explained in the thread linked above, this issue should be fixed in
> > your flashing tool, _not_ in your driver. The nand device you are
> > using does not support programming pages multiple times in a row;
> > pretending it does in the
> >
> It's not a problem of the device (Samsung K9F1G08U0B in my case)! The
> problem is that the controller generates an ECC code that is non-FF for
> all-FF data, which JFFS2 cannot handle properly.
> 
As I know, this is BCH algorithm limitation for ECC.(non-FF ECC code for all-FF data)
So that BCH engine will ignore the ECC error when all data are 0xFF. That's the BCH usage for ECC.
Under such condition, I think it's the JFFS2 that should handle such case instead
Of BCH. So far more and more SOCs are using BCH for NAND ECC, JFFS2 can't escaping such problem if
Not changed.

> 
> Lothar Wa?mann
> --
> ___________________________________________________________
> 
> Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch?ftsf?hrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
> 
> www.karo-electronics.de | info at karo-electronics.de
> ___________________________________________________________
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
