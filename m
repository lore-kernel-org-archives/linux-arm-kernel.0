From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 19 Sep 2012 12:10:35 +0200
Subject: [PATCH 4/5] ARM: EXYNOS: Add support for Exynos secure firmware
In-Reply-To: <20120916004455.GD7028@quad.lixom.net>
References: <1347524018-19301-1-git-send-email-t.figa@samsung.com>
 <1347524018-19301-5-git-send-email-t.figa@samsung.com>
 <20120916004455.GD7028@quad.lixom.net>
Message-ID: <3910462.8Opr7bJoeX@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Saturday 15 of September 2012 17:44:55 Olof Johansson wrote:
> On Thu, Sep 13, 2012 at 10:13:37AM +0200, Tomasz Figa wrote:
> > +static void __iomem *exynos_cpu_boot_reg(int cpu)
> > +{
> > +	return S5P_VA_SYSRAM_NS + 0x1c + 4*cpu;
> > +}
> 
> This communication area in sysram should probably be seen as a part of
> the firmware interface. It should thus be defined as part of the binding
> instead, i.e.  through a reg property or similar there. That also would
> make it easy to convert to using ioremap() instead of iodesc tables,
> which always a nice thing.

The problem with SYSRAM_NS is that it might be also used in other code, not 
related to firmware only. I don't know exactly all the use cases for it.

Is it really a big problem or we could let it be for now, merge the patches 
for firmware and then convert SYSRAM_NS to dynamic mapping when its 
situation clarifies?

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
