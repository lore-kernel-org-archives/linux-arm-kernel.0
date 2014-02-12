From: horms@verge.net.au (Simon Horman)
Date: Wed, 12 Feb 2014 10:35:17 +0900
Subject: [PATCH] ARM: shmobile: set proper DMA masks for Ether devices
In-Reply-To: <201402120255.25037.sergei.shtylyov@cogentembedded.com>
References: <201402120255.25037.sergei.shtylyov@cogentembedded.com>
Message-ID: <20140212013517.GE17104@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 02:55:24AM +0300, Sergei Shtylyov wrote:
> Ether MAC is a DMA-capable device and so should have 'dev.dma_mask' and
> 'dev.coherent_dma_mask' fields set properly, to reflect 32-bit DMA addressing
> ability.  Currently, the code works without DMA masks but in the future, when
> support for NETIF_F_HIGHDMA & NETIF_F_SG would be added to the 'sh_eth' driver,
> the DMA masks should start to matter...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hi Sergei,

please split this series up so there is a separate patch for each board.

Thanks

> 
> ---
> The patch is against 'renesas-devel-v3.14-rc1-20140207' tag in Simon Horman's
> 'renesas.git' repo... 
> 
>  arch/arm/mach-shmobile/board-armadillo800eva.c |    2 ++
>  arch/arm/mach-shmobile/board-bockw.c           |   21 ++++++++++++++-------
>  arch/arm/mach-shmobile/board-genmai.c          |   19 ++++++++++++++-----
>  arch/arm/mach-shmobile/board-koelsch.c         |   16 ++++++++++++----
>  arch/arm/mach-shmobile/board-lager.c           |   19 ++++++++++++++-----
>  5 files changed, 56 insertions(+), 21 deletions(-)
