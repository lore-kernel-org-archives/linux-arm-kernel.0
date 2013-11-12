From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 12 Nov 2013 14:24:41 +0100
Subject: [PATCH] ASoC: fsl-ssi: fix SDMA starvation
In-Reply-To: <52822529.5090502@tabi.org>
References: <1384255056-25673-1-git-send-email-mpa@pengutronix.de>
 <52822529.5090502@tabi.org>
Message-ID: <20131112132441.GG30263@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 06:55:05AM -0600, Timur Tabi wrote:
> Markus Pargmann wrote:
> >
> >To ensure the first edge happens after enabling the TX side of the SSI unit and
> >to trigger the SDMA unit successfully enable the CCSR_SSI_SIER_TDMAE on
> >demand only. To be sure, this patch does the same for the CCSR_SSI_SIER_RDMAE
> >(RX side) bit.
> 
> This patch impacts PowerPC as well.  Have you tested it on that platform?

No, I don't have access on PowerPC hardware, so I didn't test it on
PowerPC.

Regards,

Markus Pargmann

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
