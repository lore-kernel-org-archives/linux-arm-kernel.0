From: B04825@freescale.com (Tabi Timur-B04825)
Date: Fri, 9 Mar 2012 04:02:40 +0000
Subject: [PATCH v3 10/11] ASoC: fsl: let fsl_ssi work with imx pcm and
 machine drivers
In-Reply-To: <20120309031909.GJ2499@S2101-09.ap.freescale.net>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-11-git-send-email-shawn.guo@linaro.org>
 <4F591A69.9060401@freescale.com>
 <20120309031909.GJ2499@S2101-09.ap.freescale.net>
Message-ID: <4F5980DE.9050002@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:

> Ok, got you.  We used to set fifo_depth on imx-ssi not the value given
> by hardware manual, but the one already tuned.

What do you mean by "already tuned".  Tuned by whom?

>>> +		 */
>>> +		ssi_private->dma_params_tx.burstsize =
>>> +			ssi_private->fifo_depth - 2;
>>> +		ssi_private->dma_params_rx.burstsize =
>>> +			ssi_private->fifo_depth - 2;
>>> +		ssi_private->dma_params_tx.dma_addr =
>>> +			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, stx0);
>>> +		ssi_private->dma_params_rx.dma_addr =
>>> +			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, srx0);
>>
>> So I'm a little confused by this new binding.  I went through a lot of
>> work to remove DMA-specific data from the SSI driver, and here you are
>> aFrom arnd at arndb.de  Mon Mar 12 12:43:25 2012
From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Mar 2012 16:43:25 +0000
Subject: [PATCH 1/2] ARM: kirkwood: Basic support for DNS-320 and DNS-325
In-Reply-To: <20120312161004.GB5050@titan.lakedaemon.net>
References: <1331476406-9844-1-git-send-email-jm@lentin.co.uk>
 <201203120811.23137.arnd@arndb.de>
 <20120312161004.GB5050@titan.lakedaemon.net>
Message-ID: <201203121643.26133.arnd@arndb.de>

On Monday 12 March 2012, Jason Cooper wrote:
> Okay, that's what smelled funny.  wdt and intc both only have registers
> in virtual address space defined.  Can I assume they map like everything
> else to corresponding physical addresses?
> 
> eg wdt at fed20300 -> wdt at f1020300 ?

Yes, correct. Or just uses 20300 as the address if you remap everything
using the ranges property.

	Arnd
