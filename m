From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 6 Nov 2014 18:28:52 +0530
Subject: [PATCH] dmaengine: pl330: Correct device assignment.
In-Reply-To: <545B5E03.3040809@arm.com>
References: <545B5E03.3040809@arm.com>
Message-ID: <20141106125852.GB1870@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 11:39:47AM +0000, Andrew Jackson wrote:
> Commit f6f2421c0a1c removed pl330_info structure by embedding it into
> pl330_dmac structure, but did not ensure that the dmac->ddma.dev
> pointer gets initialised before use. When dma_alloc_coherent() gets
> called on arm64 a WARN() gets triggered due to dev being NULL.

Applied, thanks

-- 
~Vinod
