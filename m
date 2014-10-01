From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 01 Oct 2014 08:29:16 +0530
Subject: [PATCH v8 2/2] ARM: EXYNOS: Move PMU specific definitions from
 common.h
In-Reply-To: <11948982.c37J1JPj8N@wuerfel>
References: <1412072481-22370-1-git-send-email-pankaj.dubey@samsung.com>
 <1412072481-22370-3-git-send-email-pankaj.dubey@samsung.com>
 <11948982.c37J1JPj8N@wuerfel>
Message-ID: <002401cfdd23$b538dbf0$1faa93d0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tuesday, September 30, 2014 4:09 PM, Arnd Bergmann wrote,
> To: linux-arm-kernel at lists.infradead.org
> Cc: Pankaj Dubey; linux-kernel at vger.kernel.org;
linux-samsung-soc at vger.kernel.org;
> kgene.kim at samsung.com; linux at arm.linux.org.uk; naushad at samsung.com;
> tomasz.figa at gmail.com; thomas.ab at samsung.com; vikas.sajjan at samsung.com
> Subject: Re: [PATCH v8 2/2] ARM: EXYNOS: Move PMU specific definitions
from
> common.h
> 
> On Tuesday 30 September 2014 15:51:21 Pankaj Dubey wrote:
> >
> > +static inline void pmu_raw_writel(u32 val, u32 offset) {
> > +       __raw_writel(val, pmu_base_addr + offset); }
> > +
> > +static inline u32 pmu_raw_readl(u32 offset) {
> > +       return __raw_readl(pmu_base_addr + offset); }
> > +
> >
> 
> While you're at it, please convert these to use readl_relaxed() instead,
which is safe to
> use in drivers and works independent of CPU endianess.
> 

OK, I will update this. 

Thanks,
Pankaj Dubey
> 	Arnd
