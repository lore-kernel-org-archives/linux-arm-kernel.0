From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 24 Apr 2013 23:15:46 +0800
Subject: [PATCH 2/2] dma: imx-sdma: move to generic device tree bindings
In-Reply-To: <201304241652.48951.arnd@arndb.de>
References: <1366812273-10833-1-git-send-email-shawn.guo@linaro.org>
 <201304241626.22518.arnd@arndb.de>
 <20130424144318.GD2736@S2101-09.ap.freescale.net>
 <201304241652.48951.arnd@arndb.de>
Message-ID: <20130424151544.GE2736@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 04:52:48PM +0200, Arnd Bergmann wrote:
> On Wednesday 24 April 2013, Shawn Guo wrote:
> > Using macros will help us to:
> > 
> > 1) Improve the readability of "dmas" property in dts
> > 2) Keep the values stay in sync between kernel and DT
> > 
> 
> I can understand the second part, but I strongly disagree on the first one.
> Using symbolic constants in the DT will make it harder to understand because
> you now have to look in multiple places to see what you actually put in there.

So for example below, I did not use macro for the first cell which is
the DMA request ID, because it's unique for each peripheral.  But
IMX_DMATYPE_SSI_SP will be applied on all 3 SSI controllers on imx51
for 6 times (rx and tx).

	dmas = <&sdma 24 IMX_DMATYPE_SSI_SP DMA_PRIO_HIGH>,
	       <&sdma 25 IMX_DMATYPE_SSI_SP DMA_PRIO_HIGH>;
	dma-names = "rx", "tx";

Shawn

> It makes some sense for the priorities, since they get reused for each
> dma specifier.
