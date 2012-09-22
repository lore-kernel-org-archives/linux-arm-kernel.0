From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 22 Sep 2012 11:09:58 -0400
Subject: [PATCH v3 03/15] dmaengine: Add flags parameter to
 dmaengine_prep_dma_cyclic()
In-Reply-To: <1347624358-25582-4-git-send-email-peter.ujfalusi@ti.com>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
 <1347624358-25582-4-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120922150957.GH4495@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 03:05:46PM +0300, Peter Ujfalusi wrote:
> With this parameter added to dmaengine_prep_dma_cyclic() the API will be in
> sync with other dmaengine_prep_*() functions.
> The dmaengine_prep_dma_cyclic() function primarily used by audio for cyclic
> transfer required by ALSA, we use the from audio to ask dma drivers to
> suppress interrupts (if DMA_PREP_INTERRUPT is cleared) when it is supported
> on the platform.

Are you sure this was generated against for-3.7?  There's fuzz against
dmaengine.h and git can't find the blobs to do resolution.  Anyway, I
applied this and the rest of the series.
