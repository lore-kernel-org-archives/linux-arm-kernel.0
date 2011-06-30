From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 30 Jun 2011 06:46:55 +0200
Subject: [PATCH v7 1/3] MTD : add the common code for GPMI-NFC controller
	driver
In-Reply-To: <20110629143701.GC25931@S2100-06.ap.freescale.net>
References: <1309335878-16678-1-git-send-email-b32955@freescale.com>
	<1309335878-16678-2-git-send-email-b32955@freescale.com>
	<20110629100658.GE1992@pengutronix.de>
	<20110629103337.GF1992@pengutronix.de>
	<4E0B0296.6060902@freescale.com>
	<20110629122942.GH1992@pengutronix.de>
	<20110629140038.GB25931@S2100-06.ap.freescale.net>
	<20110629141557.GK1992@pengutronix.de>
	<20110629143701.GC25931@S2100-06.ap.freescale.net>
Message-ID: <20110630044655.GA19841@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> > > I would suggest leave this gpmi specific quirk to gpmi driver to sort
> > > out.  With the following mxs-dma change, it should work if gpmi driver
> > > can pass the valid gpmi irq number for only one gpmi channel, and -1
> > > for all others.
> > 
> > ...which brings us right into the 'NO_IRQ is 0' discussion :)
> > 
> Though I do not know what it means exactly, number 0 is an valid IRQ
> on both mx23 and mx28 (see mx23.h and mx28.h).

It could be remapped. It is a looong story. Start here if you are interested:

http://lkml.org/lkml/2005/11/21/221
http://yarchive.net/comp/linux/no_irq.html

Currently, it's a can of worms. Hopefully, irq_desc might help somewhen.

> > Other than that, [thinking loud] this will help if all irq-sharing
> > channels are handled by the same driver. If not, we would just add
> > IRQF_SHARED (hopefully this will never be needed). Yup, sounds
> > reasonable to me. Will give it a second thought later, though.
> > 
> GPMI is the only mxs-dma user that gets irq-sharing.  So yes, all
> irq-sharing channels are handled by the same driver, gpmi-nfc :)

Currently, yes. But we have to make it future-proof.

Regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110630/2f10ab83/attachment.sig>
