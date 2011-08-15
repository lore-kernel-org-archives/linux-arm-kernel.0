From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 15 Aug 2011 07:41:23 +0200
Subject: GPMI-NAND Status?
In-Reply-To: <20110814081139.GD17063@parrot.com>
References: <20110805135133.GA26981@pengutronix.de>
	<20110814081139.GD17063@parrot.com>
Message-ID: <20040.45443.810005.525431@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Ivan Djelic writes:
> On Fri, Aug 05, 2011 at 02:51:33PM +0100, Wolfram Sang wrote:
> (...)
> > 
> > problem overwriting all-0xff data in NAND [2]
> > =============================================
> > 
> > Although it occured only when writing JFFS2 images so far, this is a generic
> > issue and needs to be fixed, right?
> > 
> > 
> (...)
> > [2] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037104.html
> 
> As explained in the thread linked above, this issue should be fixed in your
> flashing tool, _not_ in your driver. The nand device you are using does not
> support programming pages multiple times in a row; pretending it does in the
>
It's not a problem of the device (Samsung K9F1G08U0B in my case)! The
problem is that the controller generates an ECC code that is non-FF
for all-FF data, which JFFS2 cannot handle properly.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
