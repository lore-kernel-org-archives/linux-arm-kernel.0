From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 19 Jul 2011 08:02:37 +0200
Subject: [i.MX28 GPMI] problem overwriting all-0xff data in NAND
In-Reply-To: <4E24E804.10002@freescale.com>
References: <20004.12663.29494.339601@ipc1.ka-ro>
	<20110718164354.GA3328@S2100-06.ap.freescale.net>
	<4E24E804.10002@freescale.com>
Message-ID: <20005.7677.145955.789329@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie writes:
> hi  Lothar:
> > On Mon, Jul 18, 2011 at 03:13:27PM +0200, Lothar Wa?mann wrote:
> >> Hi,
> >>
> >> with the gpmi-nfc driver for imx28 from Shawn Guo on a TX28 I
> > To be clear, the author of gpmi-nfc driver is Huang Shijie (Cc-ed).
> >
> > Regards,
> > Shawn
> >
> >> encountered some problems with jffs2 when overwriting pages that have
> >> been written with 0xff (e.g. from padding from the file system image
> >> file).
> The GPMI driver now does not support the JFFS2 very well.
> The JFFS2 will write the OOB, while the BCH of GPMI will use the OOB too.
>
I have applied a patch (from the Freescale BSPs) that prevents JFFS2
from using the OOB area. But this still doesn't help.

> So I have to disable the JFFS2 to use the OOB. I have not finish the 
> code about it now.
> 
> I recommend you use the UBIFS. But the latest version of GPMI driver 
> meets a DMA bug.
> I am debugging the DMA bug now. and I will send it out when i fix it.
> 
What sort of DMA bug?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
