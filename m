From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 16 Nov 2015 09:15:06 +0530
Subject: [PATCH 1/1] dmaengine: imx-sdma: remove __init annotation on
 sdma_event_remap
In-Reply-To: <1447233649-21464-1-git-send-email-r64343@freescale.com>
References: <1447233649-21464-1-git-send-email-r64343@freescale.com>
Message-ID: <20151116034506.GY25173@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2015 at 05:20:49PM +0800, Jason Liu wrote:
> The sdma_probe function will call sdma_event_remap, but sdma_event_remap
> marked with the __init annotation which make the kbuild complains as the
> following log:
> 
> WARNING: drivers/dma/built-in.o(.text+0x56fc): Section mismatch in reference
> from the function sdma_probe() to the function .init.text:sdma_event_remap()
> The function sdma_probe() references
> the function __init sdma_event_remap().
> This is often because sdma_probe lacks a __init
> annotation or the annotation of sdma_event_remap is wrong.
> 
> Remove the __init annotation on sdma_event_remap to kill this build warning

Applied, thanks

-- 
~Vinod
