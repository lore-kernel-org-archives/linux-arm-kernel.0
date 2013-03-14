From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 14 Mar 2013 13:42:24 +0100
Subject: [PATCH 04/10] ASoC: Kconfig: imx-ssi needs imx-fiq and imx-dma
In-Reply-To: <20130312185510.GV19942@opensource.wolfsonmicro.com>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-5-git-send-email-mpa@pengutronix.de>
 <20130312185510.GV19942@opensource.wolfsonmicro.com>
Message-ID: <20130314124224.GB32452@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 06:55:10PM +0000, Mark Brown wrote:
> On Sun, Mar 10, 2013 at 07:33:05PM +0100, Markus Pargmann wrote:
> 
> >  config SND_SOC_IMX_SSI
> > +	select SND_SOC_IMX_PCM_DMA
> > +	select SND_SOC_IMX_PCM_FIQ
> >  	tristate
> 
> Really?  I'd expect this to be an or, if we've got DMA I can't see any
> reason why we'd want to use the FIQ.

Yes, sorry, I looked at the returncodes of the devicedrivers, but
devices actually don't have to be used. So this can be dropped.

Thanks,
Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
