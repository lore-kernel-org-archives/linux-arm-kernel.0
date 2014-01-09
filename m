From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 9 Jan 2014 18:07:36 +0530
Subject: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Message-ID: <20140109123736.GG16227@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 03:08:36PM +0000, Russell King - ARM Linux wrote:
> The following patch series moves code to setup the DMA hardware and
> service interrupts from the hardware to the DMA engine driver.  This
> reduces the dependency on the legacy DMA implementation.
Didnt the code getting removed from legacy, are there any users still of
the legacy driver in mainline?

--
~Vinod
> 
> This series does not remove the channel allocation/freeing hooks which
> are used to manage the allocation of physical channels - this is the
> next step in the evolution.
> 
> The patches which move the interrupt handling are currently less than
> perfect since they're writing to ENABLE_L0 under a different spinlock,
> and hence RFC only at the moment.
> 
>  arch/arm/mach-omap1/dma.c |  183 +++++--------
>  arch/arm/mach-omap2/dma.c |  183 ++++++--------
>  arch/arm/plat-omap/dma.c  |   17 +-
>  drivers/dma/omap-dma.c    |  653 ++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/omap-dma.h  |   25 ++-
>  5 files changed, 774 insertions(+), 287 deletions(-)
> 
> -- 
> FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
> in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
> Estimate before purchase was "up to 13.2Mbit".

-- 
