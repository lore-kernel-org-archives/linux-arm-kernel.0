From: tony@atomide.com (Tony Lindgren)
Date: Fri, 8 Oct 2010 15:17:46 -0700
Subject: [PATCH v5 0/3] OMAP2/3: DMA: FIFO drain errata fixes
In-Reply-To: <20101005181525.GL3117@atomide.com>
References: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101005181525.GL3117@atomide.com>
Message-ID: <20101008221746.GS7558@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [101005 11:07]:
> * Peter Ujfalusi <peter.ujfalusi@nokia.com> [101004 23:37]:
> > Hello,
> > 
> > This v5 series is based on the v3.
> > The first two patch is the actual fix for the original problems without any
> > major change in the code (only handling the corresponding erratas in the legacy
> > way).
> > The third patch in the series is optional, and it is implementing (in one patch)
> > the errata handling via flags. This patch converts all errata cases to use the
> > introduced dma_errata variable via macros.
> > 
> > Tony: the first two patch need to go for 2.6.36, and if it is possible it shall
> > be backported to .33, .34, and .35 as well.
> 
> OK, I'll the first two into omap-fixes.

Guys, as we're so late into getting 2.6.36 tagged, I'm thinking about just
queueing these for 2.6.37 for the following reasons:

- The 24xx patch is a fix for commit c12abc0 that's was merged over a
  year ago. We've lived with it for over a year now. What difference does
  extra few more months make if we have it in 2.6.37 instead of 2.6.36?

- The second 34xx fix seems to happen only when disabling DMA on the fly.
  Again, we've had support for 34xx in the mainline kernel for a few
  years, and we're not seeing unrecoverable issues with MMC or USB or
  any other code calling omap_dma_stop().

Sure these fix major issues with the DMA, but are these really critical
for 2.6.36?

So if you really want me to argue for merging these into 2.6.36, please let
me know some oops causing cases or data corruption that happens without
these patches.

Cheers,

Tony
