From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 22 Apr 2013 11:27:48 +0100
Subject: [PATCH 05/32] dmaengine: ste_dma40: Supply macros to resolve
 'src' and 'dst' directions
In-Reply-To: <20130422094250.GJ24632@intel.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-6-git-send-email-lee.jones@linaro.org>
 <20130422094250.GJ24632@intel.com>
Message-ID: <20130422102748.GJ3432@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Apr 2013, Vinod Koul wrote:

> On Thu, Apr 18, 2013 at 11:11:47AM +0100, Lee Jones wrote:
> > There are lots of lengthy if() statements located sporadically up and
> > down the driver. This simple macro should make many of them a little
> > simpler to decipher. The remainder have to stay in place, as they
> > detail slightly more specific settings.
> I would like these to be DMAENGINE_IS_SRC...

I don't understand, as they're DMA40 specific?

> and this patch use the defines provided in dmaengine

I think a subsequent patch doing he following would be more suitable:

s/STEDMA40_MEM_TO_MEM/DMA_MEM_TO_MEM/
s/STEDMA40_MEM_TO_PERIPH/DMA_MEM_TO_DEV/
s/STEDMA40_PERIPH_TO_MEM/DMA_DEV_TO_MEM/
s/STEDMA40_PERIPH_TO_PERIPH/DMA_DEV_TO_DEV/

If you don't mind?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
