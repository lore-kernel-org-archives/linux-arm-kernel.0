From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 26 Mar 2012 12:54:11 +0530
Subject: [PATCH v5 1/2] dmaengine: Add context parameter to prep_dma_sg
 and prep_interleaved_dma
In-Reply-To: <4F7012FC.10203@codeaurora.org>
References: <1332426167-25213-1-git-send-email-kumarrav@codeaurora.org>
 <1332743073.19804.26.camel@vkoul-udesk3>  <4F7012FC.10203@codeaurora.org>
Message-ID: <1332746651.19804.81.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-03-26 at 12:25 +0530, Trilok Soni wrote:
> >
> > You need to
> > 1) add wrappers over interleaved api which dont expose this
> additional
> > parameter
> > 2) move existing users to use these wrappers
> 
> Above two steps would be exactly same as 
> https://lkml.org/lkml/2012/3/8/401 - [PATCH 1/2 V2]
> dmaengine/dma_slave: 
> introduce inline wrappers, right?
> 
> > 3) add a new API which has your additional argument (not an opaque
> > object) and this calls .device_xx callback with additional arg.
> > 4. Above can be under conditional of your specific subsystem where
> these
> > parameters are valid.
> 
> Now, this would be different from what Alexandre had submitted, since
> he 
> had added "void *context" parameter directly to existing callbacks 
> dma_slave_sg and and cyclic under struct dma_device.
In that case the wrappers existed, so he modified them and ensured all
clients use these and not the .device callbacks

So you need to create the new wrappers without any context parameter and
ensure all clients use these.
> 
> And you prefer that we add new callbacks under "struct dma_device"
> for 
> our specific requirement with new name and with that extra non-opaque 
> object. After that add wrappers for these two new callbacks say
> dmaengine_prep_dma_sg_ext and dmagengine_prep_interleaved_dma_ext
> (same
> name goes for callback).
> 
> 
-- 
~Vinod
