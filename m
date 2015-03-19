From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 19 Mar 2015 05:03:52 +0000
Subject: [PATCH 2/2 v2] ARM: configs: remove all CONFIG_RCAR_AUDMAC_PP
 from ARM defconfigs
In-Reply-To: <20150319012503.GD14051@verge.net.au>
References: <87pp8ff3sb.wl%kuninori.morimoto.gx@renesas.com>
 <87mw3jf3qe.wl%kuninori.morimoto.gx@renesas.com>
 <20150318112155.GL32683@intel.com>
 <87vbhxeubk.wl%kuninori.morimoto.gx@renesas.com>
 <20150319012503.GD14051@verge.net.au>
Message-ID: <87619xefz4.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> > > > Renesas R-Car sound (= rsnd) needs 2 DMAC which are called as
> > > > Audio DMAC (= 1st DMAC) and Audio DMAC peri peri (2nd DMAC).
> > > > And rsnd had assumed that 1st / 2nd DMACs are implemented as DMAEngine.
> > > > But, in result of DMA ML discussion, 2nd DMAC was concluded that it is
> > > > not a general purpose DMAC (2nd DMAC is for Device to Device inside
> > > > sound system). Additionally, current DMAEngine can't support Device to
> > > > Device, and we don't have correct DT bindings for it at this point.
> > > > So the easiest solution for it is that move it from DMAEngine to rsnd
> > > > driver.
> > > > Audio DMAC peri peri DMAEngine is no longer needed.
> > > > Remove all CONFIG_RCAR_AUDMAC_PP from ARM defconfigs
> > > 
> > > This fails for me, I noticed the removal is not present in topc/sh.
> > > What was this patch based on?
> > 
> > Thank you for your help.
> > I think [1/2] (= remove driver) is controlled by Vinod,
> > [2/2] (= remove setting from defconfigs) is controlled by Simon is good idea.
> > These are no relationship anymore.
> 
> This patch is probably best taken by the ARM SoC maintainers
> as it is for a generic defconfig rather than a Renesas-specific one.

OK, I see
I send it to ARM SoC maintainers / ARM-ML

Best regards
---
Kuninori Morimoto
