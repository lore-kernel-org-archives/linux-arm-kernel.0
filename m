From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 27 Nov 2014 22:48:12 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Soc Updates for v3.19
In-Reply-To: <201411192205.57149.arnd@arndb.de>
References: <cover.1415058939.git.horms+renesas@verge.net.au>
 <201411192205.57149.arnd@arndb.de>
Message-ID: <2367916.IecTPygCF4@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wednesday 19 November 2014 22:05:56 Arnd Bergmann wrote:
> On Tuesday 04 November 2014, Simon Horman wrote:
> > ----------------------------------------------------------------
> > Renesas ARM Based SoC Soc Updates for v3.19
> > 
> > * Select CONFIG_ZONE_DMA when CONFIG_ARM_LPAE is enabled
> > * Add CA7 arch_timer initialization for r8a7794
> > * Handle CA7 arch timer delay
> > * Add shmobile_init_late() to sh7372
> > 
> >   - This is consistent with other shmobile SoCs
> 
> Pulled into next/soc.
> 
> Note that the CONFIG_ZONE_DMA change might not be the best solution, we
> should probably have CONFIG_ZONE_DMA32 instead as some other architectures
> do, so you can use the entire lowmem area for DMA allocations.

I might be mistaken, but if the machine description doesn't set the 
dma_zone_size field, arm_dma_zone_size and arm_dma_limit are set to 0 and 
0xffffffff respectively. This results in MAX_DMA_ADDRESS being set to 
0xffffffff. Doesn't that allow using the entire lowmem area for DMA 
allocations ?

-- 
Regards,

Laurent Pinchart
