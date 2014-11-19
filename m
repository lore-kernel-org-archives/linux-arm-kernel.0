From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Nov 2014 22:05:56 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Soc Updates for v3.19
In-Reply-To: <cover.1415058939.git.horms+renesas@verge.net.au>
References: <cover.1415058939.git.horms+renesas@verge.net.au>
Message-ID: <201411192205.57149.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 November 2014, Simon Horman wrote:
> ----------------------------------------------------------------
> Renesas ARM Based SoC Soc Updates for v3.19
> 
> * Select CONFIG_ZONE_DMA when CONFIG_ARM_LPAE is enabled
> * Add CA7 arch_timer initialization for r8a7794
> * Handle CA7 arch timer delay
> * Add shmobile_init_late() to sh7372
>   - This is consistent with other shmobile SoCs

Pulled into next/soc.

Note that the CONFIG_ZONE_DMA change might not be the best solution, we should
probably have CONFIG_ZONE_DMA32 instead as some other architectures do, so
you can use the entire lowmem area for DMA allocations.

	Arnd
