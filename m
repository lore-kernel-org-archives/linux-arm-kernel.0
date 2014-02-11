From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Feb 2014 13:45:50 +0800
Subject: [PATCH v4 0/3] serial: fsl_lpuart: add DMA support
In-Reply-To: <c2b2798647d44d3c950ce17f23551555@DM2PR03MB349.namprd03.prod.outlook.com>
References: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
 <20140127075025.GC4765@S2101-09.ap.freescale.net>
 <c1c2915231eb4595b89327e589bc521d@BL2PR03MB338.namprd03.prod.outlook.com>
 <20140211025932.GB31484@S2101-09.ap.freescale.net>
 <c2b2798647d44d3c950ce17f23551555@DM2PR03MB349.namprd03.prod.outlook.com>
Message-ID: <20140211054548.GC31484@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 05:34:49AM +0000, Yao Yuan wrote:
> Here I also have a confusion.
> IRQ is must. But DMA isn't very necessary.
> How to deal with if one board is need DMA but another is not need?
> You mean if DMA is be support once all of them must use dma as first?

That's the point.  Why whether using DMA or not is a board decision?
The DMA resource should be defined at SoC level from the beginning
just like IO and interrupt resource.  And using DMA or PIO should be a
decision made by device driver not device tree.

Shawn
