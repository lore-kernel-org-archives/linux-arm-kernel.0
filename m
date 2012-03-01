From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 01 Mar 2012 09:00:10 +0530
Subject: [PATCH 1/2] ARM: EXYNOS: Add USB HOST register definitions
In-Reply-To: <000101ccf6ef$f4efbab0$decf3010$%han@samsung.com>
References: <000101ccf6ef$f4efbab0$decf3010$%han@samsung.com>
Message-ID: <4F4EED42.2010700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/29/2012 08:09 PM, Jingoo Han wrote:
> This patch adds USB HOST register definitions. The definition for
> EHCI INSNREG00 regiser and corresponding bit field definitions are
> added.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  arch/arm/mach-exynos/include/mach/regs-usb-host.h |   23 +++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-exynos/include/mach/regs-usb-host.h
> 
> diff --git a/arch/arm/mach-exynos/include/mach/regs-usb-host.h b/arch/arm/mach-exynos/include/mach/regs-usb-host.h
> new file mode 100644
> index 0000000..1a60f27
> --- /dev/null
> +++ b/arch/arm/mach-exynos/include/mach/regs-usb-host.h
> @@ -0,0 +1,23 @@
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
> +#define EHCI_INSNREG00(base)		(base + 0x90)
> +#define EHCI_ENA_INCR16			(0x1 << 25)
> +#define EHCI_ENA_INCR8			(0x1 << 24)
> +#define EHCI_ENA_INCR4			(0x1 << 23)
> +#define EHCI_ENA_INCRX_ALIGN		(0x1 << 22)
> +#define EHCI_ENABLE_DMA_INCR		(EHCI_ENA_INCR16 | EHCI_ENA_INCR8| \
> +					 EHCI_ENA_INCR4 | EHCI_ENA_INCRX_ALIGN)
> +
As per the definition of bit-fields in other registers, it would be good
to prepend the complete register name before the bit-field defines.

EHCI_INSNREG00_ENA_INCR16 ...

Considering the similarity of this patchset with the earlier patchset
from Sangwook, IMO, it would be appropriate to give him due credit in
both these patches.

> +#endif /* __REGS_USB_HOST_H */


-- 
Tushar Behera
