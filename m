From: Dongsheng.Wang@freescale.com (Wang Dongsheng)
Date: Fri, 18 Sep 2015 02:37:15 +0000
Subject: [PATCH] arm/ls1021a: Add Sleep feature for ls1021
In-Reply-To: <20150917123155.GC12808@leverpostej>
References: <1441877796-32232-1-git-send-email-dongsheng.wang@freescale.com>
 <20150910095920.GB29293@leverpostej>
 <SN1PR0301MB161620AA4926EEF6541D901E9D500@SN1PR0301MB1616.namprd03.prod.outlook.com>
 <20150917123155.GC12808@leverpostej>
Message-ID: <SN1PR0301MB1616F01085CC4549FFE3A1469D590@SN1PR0301MB1616.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Thursday, September 17, 2015 8:32 PM
> To: Wang Dongsheng-B40534
> Cc: shawnguo at kernel.org; Catalin Marinas; Wang Huan-B18965; Zhao Chenhui-B35336;
> Jin Zhengxiong-R64188; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; lorenzo.pieralisi at arm.com; sudeep.holla at arm.com
> Subject: Re: [PATCH] arm/ls1021a: Add Sleep feature for ls1021
> 
> On Fri, Sep 11, 2015 at 04:53:04AM +0100, Wang Dongsheng wrote:
> > Hi Mark,
> 
> Hi,
> 
> > > > > diff --git a/arch/arm/mach-imx/pm-ls1.c
> > > > > b/arch/arm/mach-imx/pm-ls1.c new file mode 100644 index
> > > > > 0000000..f80b24d
> > > > > --- /dev/null
> > > > > +++ b/arch/arm/mach-imx/pm-ls1.c
> > > > > @@ -0,0 +1,222 @@
> > > > > +/*
> > > > > + * Support Power Management Control for LS1
> > > > > + *
> > > > > + * Copyright 2015 Freescale Semiconductor Inc.
> > > > > + *
> > > > > + * This program is free software; you can redistribute	it and/or
> modify it
> > > > > + * under  the terms of	the GNU General	 Public License as
> > > published by
> > > > the
> > > > > + * Free Software Foundation;  either version 2 of the  License,
> > > > > +or (at your
> > > > > + * option) any later version.
> > > > > + */
> > > > > +
> > > > > +#include <linux/io.h>
> > > > > +#include <linux/kernel.h>
> > > > > +#include <linux/of_platform.h>
> > > > > +#include <linux/of_address.h>
> > > > > +#include <linux/psci.h>
> > > > > +#include <linux/suspend.h>
> > > > > +
> > > > > +#include <uapi/linux/psci.h>
> > > > > +
> > > > > +#include <asm/cacheflush.h>
> > > > > +#include <asm/psci.h>
> > > >
> > > > NAK.
> > > >
> > > > No new platform code should be calling the PSCI functions
> > > > directly; you should not need to include these files in platform code.
> > >
> > > PSCI 1.0 define SYSTEM_SUSPEND, and 0.2 and 0.1 not support this feature.
> > >
> > > I will drop psci-cpu_suspend to implement SYSTEM SUSPEND, and
> > > implement system suspend in platform code.
> >
> > Now 0.1 and 0.2 not support SYSTEM SUSPEND, means if do system suspend
> > we still need to use platform_suspend_ops to implement system suspend
> > in platform code and cannot use PSCI interface to do it?
> 
> As PSCI_SYSTEM_SUSPEND was introduced in PSCI 1.0, you would need a PSCI
> 1.0 implementation in order to use PSCI_SYSTEM_SUSPEND. Is there anything
> preventing implementing PSCI 1.0?
> 
> > How about PSCI 1.0 support, could you share some information about it?
> 
> Lorenzo has implemented basic PSCI 1.0 support [1,2], and Sudeep has been
> working on SYSTEM_SUSPEND [3], though I'm not immediately aware of the state of
> the world there.
> 
> Do you have any specific questions?
> 

There is no problem, I just want to use V1.0 to support our platform SYSTEM_SUSPEND,
but 1.0 implementation is not in v4.3-rc1, so abandon this.

Thanks for your help.

Regards,
-Dongsheng
