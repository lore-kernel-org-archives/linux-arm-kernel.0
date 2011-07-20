From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 20 Jul 2011 08:16:35 +0300
Subject: [i.MX28 GPMI] problem overwriting all-0xff data in NAND
In-Reply-To: <4E24E804.10002@freescale.com>
References: <20004.12663.29494.339601@ipc1.ka-ro>
	<20110718164354.GA3328@S2100-06.ap.freescale.net>
	<4E24E804.10002@freescale.com>
Message-ID: <1311139000.20738.146.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-07-19 at 10:12 +0800, Huang Shijie wrote:
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
> So I have to disable the JFFS2 to use the OOB. I have not finish the 
> code about it now.
> 
> I recommend you use the UBIFS. But the latest version of GPMI driver 
> meets a DMA bug.
> I am debugging the DMA bug now. and I will send it out when i fix it.

This is a different issue. You refer to the "GPMI-controlled flash has
no space in OOB for JFFS2". Lothar's issue is about "GPMI-controlled
flash does not allow writing 0xFFs and then writing something else",
which is very normal.

-- 
Best Regards,
Artem Bityutskiy
