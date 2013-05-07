From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 7 May 2013 10:56:12 +0800
Subject: [PATCH v2 2/2] dma: imx-sdma: move to generic device tree bindings
In-Reply-To: <20130430105105.GG1960@intel.com>
References: <1366901008-7593-1-git-send-email-shawn.guo@linaro.org>
 <1366901008-7593-3-git-send-email-shawn.guo@linaro.org>
 <20130430105105.GG1960@intel.com>
Message-ID: <20130507025609.GA10851@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 30, 2013 at 04:21:05PM +0530, Vinod Koul wrote:
> On Thu, Apr 25, 2013 at 10:43:28PM +0800, Shawn Guo wrote:
> > Update imx-sdma driver to adopt generic DMA device tree bindings.  It
> > calls of_dma_controller_register() with imx-sdma specific of_dma_xlate
> > to get the generic DMA device tree helper support.  The #dma-cells for
> > imx-sdma must be 3, which includes request ID, peripheral type and
> > priority.
> > 
> > The definitions of peripheral type and priority get moved into
> > include/dt-bindings/dma/imx.h, so that the macros can also be used in
> > dts files.
> > 
> > The existing way of requesting channel, clients directly call
> > dma_request_channel(), still work there, and will be removed after
> > all imx-sdma clients get converted to generic DMA device tree helper.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Looks fine to me, Arnd?

ping.

I was hoping we can get this in with 3.10 merge window, and start
convert client device drivers to it during 3.11 development cycle.
Is it still possible?

Shawn
