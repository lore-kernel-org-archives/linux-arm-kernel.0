From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Mon, 24 Sep 2012 02:44:35 +0000
Subject: [RFC PATCH 01/13] ARM: davinci: move private EDMA API to
 arm/common
In-Reply-To: <1348152226-13588-2-git-send-email-mporter@ti.com>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1348152226-13588-2-git-send-email-mporter@ti.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA8D0DF@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 20:13:34, Porter, Matt wrote:
> Move mach-davinci/dma.c to common/edma.c so it can be used
> by OMAP (specifically AM33xx atm) as well. This just moves
> the private EDMA API but does not support OMAP.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  arch/arm/Kconfig                           |    1 +
>  arch/arm/common/Kconfig                    |    3 +
>  arch/arm/common/Makefile                   |    1 +
>  arch/arm/common/edma.c                     | 1588 ++++++++++++++++++++++++++++
>  arch/arm/include/asm/mach/edma.h           |  267 +++++
>  arch/arm/mach-davinci/Makefile             |    2 +-
>  arch/arm/mach-davinci/devices.c            |    3 +-
>  arch/arm/mach-davinci/dm355.c              |    2 +-
>  arch/arm/mach-davinci/dm365.c              |    2 +-
>  arch/arm/mach-davinci/dm644x.c             |    2 +-
>  arch/arm/mach-davinci/dm646x.c             |    2 +-
>  arch/arm/mach-davinci/dma.c                | 1588 ----------------------------


>  arch/arm/mach-davinci/include/mach/asp.h   |    2 +-

This will clash with patch "ASoC/ARM: Davinci: McASP: split asp header
into platform and audio specific" queued in ASoC tree by Mark Brown 
tree (Auio - ASoC Tree)

I forgot to mention this last time.  Sorry

>  arch/arm/mach-davinci/include/mach/da8xx.h |    3 +-
>  arch/arm/mach-davinci/include/mach/edma.h  |  267 -----
>  arch/arm/mach-davinci/include/mach/spi.h   |    2 +-
>  arch/arm/plat-omap/Kconfig                 |    1 +
>  17 files changed, 1872 insertions(+), 1864 deletions(-)
>  create mode 100644 arch/arm/common/edma.c
>  create mode 100644 arch/arm/include/asm/mach/edma.h
>  delete mode 100644 arch/arm/mach-davinci/dma.c
>  delete mode 100644 arch/arm/mach-davinci/include/mach/edma.h
> 
...snip...
...snip...


Regards, 
Gururaja
