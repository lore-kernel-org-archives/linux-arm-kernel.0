From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Oct 2012 10:14:39 -0700
Subject: [PATCH v5 3/5] ARM: EXYNOS: Enable PMUs for exynos4
In-Reply-To: <1351056894-5790-4-git-send-email-chanho61.park@samsung.com>
References: <1351056894-5790-1-git-send-email-chanho61.park@samsung.com>
 <1351056894-5790-4-git-send-email-chanho61.park@samsung.com>
Message-ID: <CAOesGMg5Nn5i=J8o3Rt8es3Tq_LZgVttuYSBbvYfmw1QTGwx0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 23, 2012 at 10:34 PM, Chanho Park <chanho61.park@samsung.com> wrote:
> This patch defines irq numbers of ARM performance monitoring unit for exynos4.
> Firs of all, we need to fix IRQ_PMU correctly and to split pmu initialization
> of exynos from plat-samsung for easily defining it.
>
> The number of CPU cores and PMU irq numbers are vary according to soc types.
> So, we need to identify each soc type using soc_is_xxx function and to define
> the pmu irqs dynamically. For example, the exynos4412 has 4 cpu cores and pmus.

I wonder if it's worth doing this complexity on the non-DT case for exynos4?

I wish there was more focus on the Samsung platforms for getting the
DT support up to par with non-DT so you can avoid having to add new
platform devices like these in the first place.


Thanks,

-Olof
