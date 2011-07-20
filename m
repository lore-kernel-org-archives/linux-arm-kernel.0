From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 20 Jul 2011 10:51:42 +0200
Subject: [i.MX28 GPMI] problem overwriting all-0xff data in NAND
In-Reply-To: <4E263AF2.60103@freescale.com>
References: <20004.12663.29494.339601@ipc1.ka-ro>
	<20110718164354.GA3328@S2100-06.ap.freescale.net>
	<4E24E804.10002@freescale.com>
	<20005.7677.145955.789329@ipc1.ka-ro>
	<4E252C51.8070900@freescale.com>
	<20005.21635.427202.49313@ipc1.ka-ro>
	<4E263AF2.60103@freescale.com>
Message-ID: <20110720085142.GA2377@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >>>>>I am debugging the DMA bug now. and I will send it out when i fix it.
> >>>>>
> >>>>What sort of DMA bug?
> >>>>
> >>>The DMA may time-out. :(
> >>>
> >>>The DMA time-out may occur in two situations:
> >>>[1] send a command DMA descriptor, see the nfc->send_command() function.
> >>>[2] read the non-ecc data from nand, see the nfc->read_data() function.
> >>>
> >>>I don't know why. Maybe caused by the timing, or something else.
> >I am confused. The send-command DMA timeout prevents any write for me.
> >You guys surely would have noticed if you have been bitten as well. Does
> >it depend on the NAND chip?
> I think It does not depend on the NAND chip.
> My test chip is Samsung K9G8G08U0M.
> Sometimes, I can run a long time while there is no DMA timeout occurring;
> Sometimes, the bug appears right away.

For me, the bug always happens right away. So, if you need logs or debug
output or can give me a pointer into some direction, I am glad to
assist.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110720/6ee8c27d/attachment.sig>
