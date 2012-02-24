From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 24 Feb 2012 07:35:21 +0100
Subject: [PATCH v2] USB: Support for LPC32xx SoC
In-Reply-To: <4F46AA06.30502@antcom.de>
References: <1330030639-3796-1-git-send-email-stigge@antcom.de>
 <4F46AA06.30502@antcom.de>
Message-ID: <20120224063521.GA16412@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> To get rid of the remaining #ifdefs, I could as well create a new
> ohci-lpc32xx.c instead of abusing ohci-pnx4008.c. Would this be the way
> to go or are there any other suggestions?

If you could tell the difference between pnx4008 and lpc32xx, then you could
simply do something like:

	if (machine_is_pnx4008)
		pnx4008_configure();
	else
		lpc32xx_configure();

or

	if (machine_is_pnx4008)
		pnx4008_(un)set_usb_bits

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120224/0121d2f4/attachment.sig>
