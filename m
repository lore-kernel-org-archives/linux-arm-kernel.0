From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 14 Apr 2013 17:20:16 +0200
Subject: [PATCH v2 05/11] ASoC: fsl-ssi: Add support for imx-pcm-fiq
In-Reply-To: <516AC305.2000800@tabi.org>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-6-git-send-email-mpa@pengutronix.de>
 <51620CEA.3010703@tabi.org> <20130414103819.GA27394@pengutronix.de>
 <516AB111.3000007@tabi.org> <20130414141015.GC27394@pengutronix.de>
 <516AC305.2000800@tabi.org>
Message-ID: <20130414152016.GE27394@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 14, 2013 at 09:53:57AM -0500, Timur Tabi wrote:
> Markus Pargmann wrote:
> >In general, imx27 does support SSI with DMA, for example
> >MACH_IMX27_VISSTRIM_M10 does use SSI with DMA. But there are special
> >boards like Eukrea TLV320 and phycore-ac97 that have to use FIQ instead.
> >All of them have a imx27 chip.
> 
> Why is the decision to use FIQ board-specific?  All of the hardware
> is inside the SoC itself.  How could a board make using DMA
> impossible?

I only ported the imx-ssi ac97 driver code and tested twice using DMA
without success. But there is a good description of the problem in
imx-ssi:

" The WM9712 with which this driver
was developed with always sends GPIO status data in slot 12 which
we receive in our (PCM-) data stream. The only chance we have is to
manually skip this data in the FIQ handler."

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
