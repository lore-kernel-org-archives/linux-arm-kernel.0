From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 05 Mar 2012 10:18:00 +0900
Subject: [PATCH v2 1/2] ARM: EXYNOS: Add USB HOST register definitions
In-Reply-To: <201203011624.04551.heiko@sntech.de>
References: <000701ccf76d$8316b0a0$894411e0$%han@samsung.com>
 <201203011624.04551.heiko@sntech.de>
Message-ID: <006001ccfa6d$ce97b5d0$6bc72170$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Heiko Stubner
> Sent: Friday, March 02, 2012 12:24 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Jingoo Han; linux-usb at vger.kernel.org; linux-samsung-soc at vger.kernel.org; 'Kukjin Kim'; linaro-
> dev at lists.linaro.org; 'Joonyoung Shim'; patches at linaro.org; 'Greg Kroah-Hartman'; 'Sangwook Lee'; 'Alan
> Stern'; 'Thomas Abraham'
> Subject: Re: [PATCH v2 1/2] ARM: EXYNOS: Add USB HOST register definitions
> 
> Am Donnerstag, 1. M?rz 2012, 06:38:20 schrieb Jingoo Han:
> > This patch adds USB HOST register definitions. The definition for
> > EHCI INSNREG00 regiser and corresponding bit field definitions are
> > added.
> >
> > Signed-off-by: Sangwook Lee <sangwook.lee@linaro.org>
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> > v2: change the definition name from EHCI_ENA_xxx to EHCI_INSNREG00_ENA_xxx.
> >
> > arch/arm/mach-exynos/include/mach/regs-usb-host.h |   24
> > +++++++++++++++++++++ 1 files changed, 24 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-exynos/include/mach/regs-usb-host.h
> Isn't the general idea to depopulate the mach directories and make drivers
> buildable across architectures?
> 
> The definitions are only used in drivers/usb/host/ehci-s5p.c [in the second
> patch], so there should be no need to add another arch-header and they could
> simply be included in the driver itself or if necessary a
> drivers/usb/host/ehci-s5p.h 
Hi, Heiko St?bner.

OK, I will move the register definitions from arch/arm/mach-exynos/include/mach to
drivers/usb/host/ehci-s5p.c.

Thank you for your suggestion.

> 
> 
> Heiko
> 
> > diff --git a/arch/arm/mach-exynos/include/mach/regs-usb-host.h
> > b/arch/arm/mach-exynos/include/mach/regs-usb-host.h new file mode 100644
> > index 0000000..572b7d4
> > --- /dev/null
> > +++ b/arch/arm/mach-exynos/include/mach/regs-usb-host.h
> > @@ -0,0 +1,24 @@
> > +/*
> > + * Copyright (C) 2012 Samsung Electronics Co.Ltd
> > + *		http://www.samsung.com
> > + *
> > + * EXYNOS - USB HOST register definitions
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef __REGS_USB_HOST_H
> > +#define __REGS_USB_HOST_H __FILE__
> > +
> > +#define EHCI_INSNREG00(base)			(base + 0x90)
> > +#define EHCI_INSNREG00_ENA_INCR16		(0x1 << 25)
> > +#define EHCI_INSNREG00_ENA_INCR8		(0x1 << 24)
> > +#define EHCI_INSNREG00_ENA_INCR4		(0x1 << 23)
> > +#define EHCI_INSNREG00_ENA_INCRX_ALIGN		(0x1 << 22)
> > +#define EHCI_INSNREG00_ENABLE_DMA_BURST	\
> > +	(EHCI_INSNREG00_ENA_INCR16 | EHCI_INSNREG00_ENA_INCR8 |	\
> > +	 EHCI_INSNREG00_ENA_INCR4 | EHCI_INSNREG00_ENA_INCRX_ALIGN)
> > +
> > +#endif /* __REGS_USB_HOST_H */
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
