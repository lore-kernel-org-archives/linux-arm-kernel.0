From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 19 Aug 2015 22:32:48 +0530
Subject: [PATCHv4 3/6] dmaengine: mv_xor: remove support for dmacap,* DT
 properties
In-Reply-To: <1436365699-6862-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1436365699-6862-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1436365699-6862-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150819170248.GL13546@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 04:28:16PM +0200, Thomas Petazzoni wrote:
> The only reason why we had dmacap,* properties is because back when
> DMA_MEMSET was supported, only one out of the two channels per engine
> could do a memset operation. But this is something that the driver
> already knows anyway, and since then, the DMA_MEMSET support has been
> removed.
> 
> The driver is already well aware of what each channel supports and the
> one to one mapping between Linux specific implementation details (such
> as dmacap,interrupt enabling DMA_INTERRUPT) and DT properties is a
> good indication that these DT properties are wrong.
> 
> Therefore, this commit simply gets rid of these dmacap,* properties,
> they are now ignored, and the driver is responsible for knowing the
> capabilities of the hardware with regard to the dmaengine subsystem
> expectations.

Applied, thanks

-- 
~Vinod
