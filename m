From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 5 Jun 2013 14:24:38 +0530
Subject: [PATCH v9 1/9] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <1362586540-10393-2-git-send-email-mporter@ti.com>
References: <1362586540-10393-1-git-send-email-mporter@ti.com>
 <1362586540-10393-2-git-send-email-mporter@ti.com>
Message-ID: <51AEFCCE.4040608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 3/6/2013 9:45 PM, Matt Porter wrote:
> Move mach-davinci/dma.c to common/edma.c so it can be used
> by OMAP (specifically AM33xx) as well.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> Acked-by: Sekhar Nori <nsekhar@ti.com>

Can you please ack this movement of davinci private EDMA implementation
to arch/arm/common? I would like to take this patch through davinci tree
for v3.11.

Thanks,
Sekhar

> ---
>  arch/arm/Kconfig                                   |    1 +
>  arch/arm/common/Kconfig                            |    3 +
>  arch/arm/common/Makefile                           |    1 +
>  arch/arm/{mach-davinci/dma.c => common/edma.c}     |    2 +-
>  arch/arm/mach-davinci/Makefile                     |    2 +-
>  arch/arm/mach-davinci/board-tnetv107x-evm.c        |    2 +-
>  arch/arm/mach-davinci/davinci.h                    |    2 +-
>  arch/arm/mach-davinci/devices-tnetv107x.c          |    2 +-
>  arch/arm/mach-davinci/devices.c                    |    6 +-
>  arch/arm/mach-davinci/dm355.c                      |    2 +-
>  arch/arm/mach-davinci/dm365.c                      |    2 +-
>  arch/arm/mach-davinci/dm644x.c                     |    2 +-
>  arch/arm/mach-davinci/dm646x.c                     |    2 +-
>  arch/arm/mach-davinci/include/mach/da8xx.h         |    2 +-
>  drivers/dma/edma.c                                 |    2 +-
>  drivers/mmc/host/davinci_mmc.c                     |    1 +
>  include/linux/mfd/davinci_voicecodec.h             |    3 +-
>  .../mach => include/linux/platform_data}/edma.h    |   89 +-------------------
>  include/linux/platform_data/spi-davinci.h          |    2 +-
>  sound/soc/davinci/davinci-evm.c                    |    1 +
>  sound/soc/davinci/davinci-pcm.c                    |    1 +
>  sound/soc/davinci/davinci-pcm.h                    |    2 +-
>  sound/soc/davinci/davinci-sffsdr.c                 |    5 +-
>  23 files changed, 33 insertions(+), 104 deletions(-)
>  rename arch/arm/{mach-davinci/dma.c => common/edma.c} (99%)
>  rename {arch/arm/mach-davinci/include/mach => include/linux/platform_data}/edma.h (59%)
> 
