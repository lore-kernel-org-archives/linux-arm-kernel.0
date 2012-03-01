From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 1 Mar 2012 16:24:03 +0100
Subject: [PATCH v2 1/2] ARM: EXYNOS: Add USB HOST register definitions
In-Reply-To: <000701ccf76d$8316b0a0$894411e0$%han@samsung.com>
References: <000701ccf76d$8316b0a0$894411e0$%han@samsung.com>
Message-ID: <201203011624.04551.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 1. M?rz 2012, 06:38:20 schrieb Jingoo Han:
> This patch adds USB HOST register definitions. The definition for
> EHCI INSNREG00 regiser and corresponding bit field definitions are
> added.
> 
> Signed-off-by: Sangwook Lee <sangwook.lee@linaro.org>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> v2: change the definition name from EHCI_ENA_xxx to EHCI_INSNREG00_ENA_xxx.
> 
> arch/arm/mach-exynos/include/mach/regs-usb-host.h |   24
> +++++++++++++++++++++ 1 files changed, 24 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-exynos/include/mach/regs-usb-host.h
Isn't the general idea to depopulate the mach directories and make drivers 
buildable across architectures?

The definitions are only used in drivers/usb/host/ehci-s5p.c [in the second 
patch], so there should be no need to add another arch-header and they could 
simply be included in the driver itself or if necessary a 
drivers/usb/host/ehci-s5p.h .


Heiko

> diff --git a/arch/arm/mach-exynos/include/mach/regs-usb-host.h
> b/arch/arm/mach-exynos/include/mach/regs-usb-host.h new file mode 100644
> index 0000000..572b7d4
> --- /dev/null
> +++ b/arch/arm/mach-exynos/include/mach/regs-usb-host.h
> @@ -0,0 +1,24 @@
> +/*
> + * Copyright (C) 2012 Samsung Electronics Co.Ltd
> + *		http://www.samsung.com
> + *
> + * EXYNOS - USB HOST register definitions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __REGS_USB_HOST_H
> +#define __REGS_USB_HOST_H __FILE__
> +
> +#define EHCI_INSNREG00(base)			(base + 0x90)
> +#define EHCI_INSNREG00_ENA_INCR16		(0x1 << 25)
> +#define EHCI_INSNREG00_ENA_INCR8		(0x1 << 24)
> +#define EHCI_INSNREG00_ENA_INCR4		(0x1 << 23)
> +#define EHCI_INSNREG00_ENA_INCRX_ALIGN		(0x1 << 22)
> +#define EHCI_INSNREG00_ENABLE_DMA_BURST	\
> +	(EHCI_INSNREG00_ENA_INCR16 | EHCI_INSNREG00_ENA_INCR8 |	\
> +	 EHCI_INSNREG00_ENA_INCR4 | EHCI_INSNREG00_ENA_INCRX_ALIGN)
> +
> +#endif /* __REGS_USB_HOST_H */
