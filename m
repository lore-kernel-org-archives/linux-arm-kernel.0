From: Mohit.KUMAR@st.com (Mohit KUMAR DCG)
Date: Fri, 13 Dec 2013 12:30:03 +0800
Subject: [PATCH 09/12] pcie: SPEAr13xx: Add designware pcie support
In-Reply-To: <201312120000.54545.arnd@arndb.de>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <f5c9cbbd116d462c428afc2e8afefd95aad8c6ec.1386752447.git.mohit.kumar@st.com>
 <201312120000.54545.arnd@arndb.de>
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189F95F66A2@EAPEX1MAIL1.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Thursday, December 12, 2013 4:31 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Mohit KUMAR DCG; linux-pci at vger.kernel.org; Pratyush ANAND; Jingoo
> Han; Viresh Kumar; spear-devel
> Subject: Re: [PATCH 09/12] pcie: SPEAr13xx: Add designware pcie support
> 
> On Wednesday 11 December 2013, Mohit Kumar wrote:
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/resource.h>
> > +#include <mach/spear.h>
> 
> This won't actually build: you cannot access mach/*.h header files from
> outside of mach-spear!

- OK, will fix it.

> 
> > +struct spear13xx_pcie {
> > +	void __iomem		*phy_base;
> > +	void __iomem		*app_base;
> > +	struct clk		*clk;
> > +	struct pcie_port	pp;
> > +	int			id;
> > +	int			is_gen1;
> > +};
> 
> The pcie driver shouldn't have direct access to the phy registers, use a phy
> driver for that.

- OK. In few workarounds we have to access controller as well as phy registers,
How we should handle such cases if we separate out phy driver from here? Should it be
through phy global functions called from pcie driver?

Thanks
Mohit
