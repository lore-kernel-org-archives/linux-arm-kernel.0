From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 26 Jun 2013 15:07:30 +0100
Subject: [PATCH] arch: arm64: include: asm: add pci.h to pass compiling
In-Reply-To: <51CA5F71.207@asianux.com>
References: <51CA5F71.207@asianux.com>
Message-ID: <20130626140730.GB23309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 04:26:41AM +0100, Chen Gang wrote:
> Need add pci.h for compiling, the related error (with allmodconfig):
> 
>   drivers/media/usb/b2c2/flexcop-usb.c: In function ?flexcop_usb_transfer_exit?:
>   drivers/media/usb/b2c2/flexcop-usb.c:393:3: error: implicit declaration of function ?pci_free_consistent? [-Werror=implicit-function-declaration]
>   drivers/media/usb/b2c2/flexcop-usb.c: In function ?flexcop_usb_transfer_init?:
>   drivers/media/usb/b2c2/flexcop-usb.c:410:2: error: implicit declaration of function ?pci_alloc_consistent? [-Werror=implicit-function-declaration]
>   drivers/media/usb/b2c2/flexcop-usb.c:410:21: warning: assignment makes pointer from integer without a cast [enabled by default]
>   cc1: some warnings being treated as errors
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm64/include/asm/pci.h |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm64/include/asm/pci.h
> 
> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> new file mode 100644
> index 0000000..2ed467f
> --- /dev/null
> +++ b/arch/arm64/include/asm/pci.h
> @@ -0,0 +1,11 @@
> +#ifndef ASMARM64_PCI_H
> +#define ASMARM64_PCI_H
> +
> +#ifdef __KERNEL__
> +
> +#include <asm-generic/pci-dma-compat.h>
> +#include <asm-generic/pci.h>
> +
> +#endif /* __KERNEL__ */
> +
> +#endif

I wonder whether it makes sense to include pci-dma-compat.h in
asm-generic/pci.h, I don't see why one would want the generic pci.h but
not the generic pci-dma-compat.h (cc'ing Arnd).

-- 
Catalin
