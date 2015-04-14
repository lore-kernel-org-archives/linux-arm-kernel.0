From: jbe@pengutronix.de (Juergen Borleis)
Date: Tue, 14 Apr 2015 11:42:00 +0200
Subject: [RFC] i.MX25/35/SDHCI: switch off DMA usage
In-Reply-To: <20150327114400.GA20277@shlinux1.ap.freescale.net>
References: <201503271152.04348.jbe@pengutronix.de>
 <20150327114400.GA20277@shlinux1.ap.freescale.net>
Message-ID: <201504141142.00237.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 27 March 2015 12:44:03 Dong Aisheng wrote:
> On Fri, Mar 27, 2015 at 11:52:04AM +0100, Juergen Borleis wrote:
> > DMA and the required overhead on very small data blocks seems an
> > expensive operation. Due to erratum ENGCM07207 for i.MX25 and i.MX35 SoCs
> > the support for multiblock transfers is disabled which results into a
> > huge amount of single 512 byte sector transfers and interrupts. This
> > slows down the transmission speed to below 500 kiB/s (even at 50 MHz SD
> > card clock). Using PIO instead of DMA to avoid ENGCM07207 happens and
> > re-enabling multiblock transfers again improve the transmission
> > capability up to about 2.5 MiB/s.
> >
> > I'm still not sure if ENGCM07207 is related to DMA only and can not
> > happen when PIO is used instead. Someone out there with experience
> > regarding this topic?
>
> The errata does not state it's related to DMA only.
> http://cache.freescale.com/files/dsp/doc/errata/IMX35CE.pdf
> I could double check with our IC guys to confirm it.

Gentle ping.

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Borleis ? ? ? ? ? ? |
Industrial Linux Solutions               ? ? ?| http://www.pengutronix.de/  |
