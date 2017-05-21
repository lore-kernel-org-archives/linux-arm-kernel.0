From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 21 May 2017 15:05:58 +0800
Subject: [PATCH 2/4] ARM: imx: add initial support for imx7ulp
In-Reply-To: <20170518053006.GA28011@b29396-OptiPlex-7040>
References: <1495036217-20049-1-git-send-email-aisheng.dong@nxp.com>
 <1495036217-20049-3-git-send-email-aisheng.dong@nxp.com>
 <51686046.22567.1495042602979@email.1und1.de>
 <20170518053006.GA28011@b29396-OptiPlex-7040>
Message-ID: <20170521070553.GF26102@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 01:30:06PM +0800, Dong Aisheng wrote:
> > > diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
> > > new file mode 100644
> > > index 0000000..df5d6b6
> > > --- /dev/null
> > > +++ b/arch/arm/mach-imx/pm-imx7ulp.c
> > > @@ -0,0 +1,33 @@
> > > +/*
> > > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > > + * Copyright (C) 2017 NXP
> > > + *
> > > + * The code contained herein is licensed under the GNU General Public
> > > + * License. You may obtain a copy of the GNU General Public License
> > > + * Version 2 or later at the following locations:
> > > + *
> > > + * http://www.opensource.org/licenses/gpl-license.html
> > > + * http://www.gnu.org/copyleft/gpl.html
> > > + */
> > > +
> > > +#include <linux/io.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_address.h>
> > > +
> > > +#define SMC_PMCTRL		0x10
> > > +#define BP_PMCTRL_PSTOPO        16
> > > +#define PSTOPO_PSTOP3		0x3
> > > +
> > > +void __init imx7ulp_pm_init(void)
> > > +{
> > > +	struct device_node *np;
> > > +	void __iomem *smc1_base;
> > > +
> > > +	np = of_find_compatible_node(NULL, NULL, "fsl,imx7ulp-smc1");
> > 
> > so actually there no dt-binding for this compatible, because there is no driver?
> 
> Yes, probably we'd better add another binding doc for it under
> Documentation/devicetree/bindings/arm/freescale/.
> And there's another fsl,aips-bus also has no binding doc, i'm not sure
> whether we need add a binding doc it as well. It seems already exist
> on many imx dts files.
> 
> Shawn,
> your suggestion?

Strictly speaking, every compatible should be documented.  But in
reality, some compatibles not used by kernel may be missing the
documentation.  You're welcomed to add them.

Shawn
