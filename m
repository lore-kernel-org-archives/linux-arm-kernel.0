From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 11 Sep 2012 15:20:59 +0200
Subject: [PATCH 01/16] ARM: at91: move platform_data definitions
In-Reply-To: <1347368390-31252-1-git-send-email-arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-1-git-send-email-arnd@arndb.de>
Message-ID: <20120911132059.GG31430@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:59 Tue 11 Sep     , Arnd Bergmann wrote:
> Platform data for device drivers should be defined in
> include/linux/platform_data/*.h, not in the architecture
> and platform specific directories.
> 
> This moves such data out of the at91 include directories
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> ---
>  arch/arm/mach-at91/at91sam9g45_devices.c                             |    2 +-
>  arch/arm/mach-at91/at91sam9rl_devices.c                              |    2 +-
>  arch/arm/mach-at91/include/mach/atmel-mci.h                          |    2 +-
>  drivers/dma/at_hdmac_regs.h                                          |    2 +-
>  include/linux/platform_data/atmel-aes.h                              |    2 +-
>  .../mach/at_hdmac.h => include/linux/platform_data/dma-atmel.h       |    0
>  6 files changed, 5 insertions(+), 5 deletions(-)
>  rename arch/arm/mach-at91/include/mach/at_hdmac.h => include/linux/platform_data/dma-atmel.h (100%)
> 
> diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
> index 0607399..0aa9bdb 100644
> --- a/arch/arm/mach-at91/at91sam9g45_devices.c
> +++ b/arch/arm/mach-at91/at91sam9g45_devices.c
> @@ -31,7 +31,7 @@
>  #include <mach/at91sam9g45_matrix.h>
>  #include <mach/at91_matrix.h>
>  #include <mach/at91sam9_smc.h>
> -#include <mach/at_hdmac.h>
> +#include <linux/platform_data/dma-atmel.h>
>  #include <mach/atmel-mci.h>
>  
>  #include <media/atmel-isi.h>
> diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
> index f09fff9..e4da717 100644
> --- a/arch/arm/mach-at91/at91sam9rl_devices.c
> +++ b/arch/arm/mach-at91/at91sam9rl_devices.c
> @@ -22,7 +22,7 @@
>  #include <mach/at91sam9rl_matrix.h>
>  #include <mach/at91_matrix.h>
>  #include <mach/at91sam9_smc.h>
> -#include <mach/at_hdmac.h>
> +#include <linux/platform_data/dma-atmel.h>
I prefer to have all of them in atmel.h

as I started

Best Regards,
J.
>  
>  #include "generic.h"
>  
> diff --git a/arch/arm/mach-at91/include/mach/atmel-mci.h b/arch/arm/mach-at91/include/mach/atmel-mci.h
> index 998cb0c..cd580a1 100644
> --- a/arch/arm/mach-at91/include/mach/atmel-mci.h
> +++ b/arch/arm/mach-at91/include/mach/atmel-mci.h
> @@ -1,7 +1,7 @@
>  #ifndef __MACH_ATMEL_MCI_H
>  #define __MACH_ATMEL_MCI_H
>  
> -#include <mach/at_hdmac.h>
> +#include <linux/platform_data/dma-atmel.h>
>  
>  /**
>   * struct mci_dma_data - DMA data for MCI interface
> diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
> index 8a6c8e8..116e4ad 100644
> --- a/drivers/dma/at_hdmac_regs.h
> +++ b/drivers/dma/at_hdmac_regs.h
> @@ -11,7 +11,7 @@
>  #ifndef AT_HDMAC_REGS_H
>  #define	AT_HDMAC_REGS_H
>  
> -#include <mach/at_hdmac.h>
> +#include <linux/platform_data/dma-atmel.h>
>  
>  #define	AT_DMA_MAX_NR_CHANNELS	8
>  
> diff --git a/include/linux/platform_data/atmel-aes.h b/include/linux/platform_data/atmel-aes.h
> index e7a1949..ab68082 100644
> --- a/include/linux/platform_data/atmel-aes.h
> +++ b/include/linux/platform_data/atmel-aes.h
> @@ -1,7 +1,7 @@
>  #ifndef __LINUX_ATMEL_AES_H
>  #define __LINUX_ATMEL_AES_H
>  
> -#include <mach/at_hdmac.h>
> +#include <linux/platform_data/dma-atmel.h>
>  
>  /**
>   * struct aes_dma_data - DMA data for AES
> diff --git a/arch/arm/mach-at91/include/mach/at_hdmac.h b/include/linux/platform_data/dma-atmel.h
> similarity index 100%
> rename from arch/arm/mach-at91/include/mach/at_hdmac.h
> rename to include/linux/platform_data/dma-atmel.h
> -- 
> 1.7.10
> 
