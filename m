From: chanho61.park@samsung.com (Chanho Park)
Date: Thu, 25 Oct 2012 10:41:46 +0900
Subject: [PATCH v5 3/5] ARM: EXYNOS: Enable PMUs for exynos4
In-Reply-To: <CAOesGMg5Nn5i=J8o3Rt8es3Tq_LZgVttuYSBbvYfmw1QTGwx0A@mail.gmail.com>
References: <1351056894-5790-1-git-send-email-chanho61.park@samsung.com>
 <1351056894-5790-4-git-send-email-chanho61.park@samsung.com>
 <CAOesGMg5Nn5i=J8o3Rt8es3Tq_LZgVttuYSBbvYfmw1QTGwx0A@mail.gmail.com>
Message-ID: <005801cdb251$e52f7480$af8e5d80$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Olof Johansson [mailto:olof at lixom.net]
> Sent: Thursday, October 25, 2012 2:15 AM
> To: Chanho Park
> Cc: kgene.kim at samsung.com; linux-samsung-soc at vger.kernel.org; linux-
> arm-kernel at lists.infradead.org; linux at arm.linux.org.uk; ben-linux at fluff.org;
> kyungmin.park at samsung.com; sachin.kamat at linaro.org;
> thomas.abraham at linaro.org; will.deacon at arm.com
> Subject: Re: [PATCH v5 3/5] ARM: EXYNOS: Enable PMUs for exynos4
> 
> Hi,
> 
> On Tue, Oct 23, 2012 at 10:34 PM, Chanho Park
> <chanho61.park@samsung.com> wrote:
> > This patch defines irq numbers of ARM performance monitoring unit for
> exynos4.
> > Firs of all, we need to fix IRQ_PMU correctly and to split pmu
> > initialization of exynos from plat-samsung for easily defining it.
> >
> > The number of CPU cores and PMU irq numbers are vary according to soc
> types.
> > So, we need to identify each soc type using soc_is_xxx function and to
> > define the pmu irqs dynamically. For example, the exynos4412 has 4 cpu
> cores and pmus.
> 
> I wonder if it's worth doing this complexity on the non-DT case for exynos4?
> 
> I wish there was more focus on the Samsung platforms for getting the DT
> support up to par with non-DT so you can avoid having to add new platform
> devices like these in the first place.

The DT support of exynos4 is under development.
And many of exynos4 developers still use non-dt boot-up method.
By this time arm-pmu of exynos did not work. IMO we should fix and support it
for non-dt users.

Thanks,

Best regards,
Chanho Park

> 
> 
> Thanks,
> 
> -Olof
