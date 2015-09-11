From: Dongsheng.Wang@freescale.com (Wang Dongsheng)
Date: Fri, 11 Sep 2015 03:42:23 +0000
Subject: [PATCH] arm/ls1021a: Add Sleep feature for ls1021
In-Reply-To: <20150910095920.GB29293@leverpostej>
References: <1441877796-32232-1-git-send-email-dongsheng.wang@freescale.com>
 <20150910095920.GB29293@leverpostej>
Message-ID: <SN1PR0301MB16161ED445AC81093990F8549D500@SN1PR0301MB1616.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks for your review.

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Thursday, September 10, 2015 5:59 PM
> To: Wang Dongsheng-B40534
> Cc: shawnguo at kernel.org; Catalin Marinas; Wang Huan-B18965; Zhao Chenhui-B35336;
> Jin Zhengxiong-R64188; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH] arm/ls1021a: Add Sleep feature for ls1021
> 
> On Thu, Sep 10, 2015 at 10:36:36AM +0100, Dongsheng Wang wrote:
> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > Based on PSCI framework, add system STANDBY implement for ls1021 platform.
> >
> > Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> > index fb689d8..d7a2d1d 100644
> > --- a/arch/arm/mach-imx/Makefile
> > +++ b/arch/arm/mach-imx/Makefile
> > @@ -90,6 +90,7 @@ ifeq ($(CONFIG_SUSPEND),y)  AFLAGS_suspend-imx6.o
> > :=-Wa,-march=armv7-a
> >  obj-$(CONFIG_SOC_IMX6) += suspend-imx6.o
> >  obj-$(CONFIG_SOC_IMX53) += suspend-imx53.o
> > +obj-$(CONFIG_SOC_LS1021A) += pm-ls1.o
> >  endif
> >  obj-$(CONFIG_SOC_IMX6) += pm-imx6.o
> >
> > diff --git a/arch/arm/mach-imx/pm-ls1.c b/arch/arm/mach-imx/pm-ls1.c
> > new file mode 100644 index 0000000..f80b24d
> > --- /dev/null
> > +++ b/arch/arm/mach-imx/pm-ls1.c
> > @@ -0,0 +1,222 @@
> > +/*
> > + * Support Power Management Control for LS1
> > + *
> > + * Copyright 2015 Freescale Semiconductor Inc.
> > + *
> > + * This program is free software; you can redistribute	it and/or modify it
> > + * under  the terms of	the GNU General	 Public License as published by
> the
> > + * Free Software Foundation;  either version 2 of the  License, or
> > +(at your
> > + * option) any later version.
> > + */
> > +
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/of_address.h>
> > +#include <linux/psci.h>
> > +#include <linux/suspend.h>
> > +
> > +#include <uapi/linux/psci.h>
> > +
> > +#include <asm/cacheflush.h>
> > +#include <asm/psci.h>
> 
> NAK.
> 
> No new platform code should be calling the PSCI functions directly; you should
> not need to include these files in platform code.

PSCI 1.0 define SYSTEM_SUSPEND, and 0.2 and 0.1 not support this feature.

I will drop psci-cpu_suspend to implement SYSTEM SUSPEND, and implement system suspend
in platform code.

Regards,
-Dongsheng
