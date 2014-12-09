From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 9 Dec 2014 14:42:48 +0530
Subject: [PATCHv4] dmaengine: fsl-edma: fixup reg offset and hw S/G
 support in big-endian model
In-Reply-To: <1413968035-12855-1-git-send-email-jingchang.lu@freescale.com>
References: <1413968035-12855-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <20141209091248.GA16827@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 04:53:55PM +0800, Jingchang Lu wrote:
> The offset of all 8-/16-bit registers in big-endian eDMA model are
> swapped in a 32-bit size opposite those in the little-endian model.
> 
> The hardware Scatter/Gather requires the subsequent TCDs stored in memory
> in little endian independent of the register endian model, the eDMA engine
> will do the swap if need.
> 
> This patch also use regular assignment for tcd variables r/w
> instead of with io function previously that may not always be true.
Applied, thanks

-- 
~Vinod
