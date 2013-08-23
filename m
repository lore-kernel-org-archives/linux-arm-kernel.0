From: b32955@freescale.com (Huang Shijie)
Date: Fri, 23 Aug 2013 10:14:38 +0800
Subject: [PATCH V1 4/5] spi: Add Freescale QuadSpi driver
In-Reply-To: <20130822192158.GA10038@ld-irv-0074.broadcom.com>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
 <1376885403-12156-5-git-send-email-b32955@freescale.com>
 <20130822192158.GA10038@ld-irv-0074.broadcom.com>
Message-ID: <5216C58E.2040400@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?08?23? 03:21, Brian Norris ??:
> Can this controller support more than one chip? If so, then the nor-size
> property makes even less sense. See below.
>
yes.

this controller can supports two same chips at the same time.
>> >  +- clocks : The clocks needed by the QuadSPI controller
>> >  +- clock-names : the name of the clocks
>> >  +
>> >  +Optional properties:
>> >  +- fsl,nor-size : The NOR size used by the QuadSPI mapping.
> Why does the size of the NOR flash need to be in the controller's device
> node? Shouldn't this be detected at run-time if possible? Or at least
yes, i can parse out the NOR size by the DT node.

I can remove this DT property in the next version.


> included as a property of m25p80, if absolutely required?
the m25p80 has already contains the NOR size by: sector_size * n_sectors.
but as a spi driver , there is no API i can use to get the NOR size.

thanks
Huang Shijie
