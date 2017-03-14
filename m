From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 14 Mar 2017 16:53:33 +0100
Subject: [PATCH v2 4/4] phy: exynos: Use one define for enable bit
In-Reply-To: <CAJKOXPeUYeAuXgZLVYTBNTZhcmiEMr6sfWWpXMytzzeC0+wY4Q@mail.gmail.com>
References: <20170311182534.13345-1-krzk@kernel.org>
 <2746282.jBJ7tRjldv@amdc3058>
 <CAJKOXPeUYeAuXgZLVYTBNTZhcmiEMr6sfWWpXMytzzeC0+wY4Q@mail.gmail.com>
 <CGME20170314155351epcas5p210791391569477d6b115bb922ab068ed@epcas5p2.samsung.com>
Message-ID: <2409116.U9sOiGfLuq@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 14, 2017 04:55:46 PM Krzysztof Kozlowski wrote:
> On Tue, Mar 14, 2017 at 4:46 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> >
> > Hi,
> >
> > On Saturday, March 11, 2017 08:25:34 PM Krzysztof Kozlowski wrote:
> >> There is no need for separate defines for Exynos4 and Exynos5 phy enable
> >> bit and MIPI phy reset bits.  In both cases there are the same so
> >> simplify it.
> >>
> >> This reduces number of defines and allows removal of one header file.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >> Acked-by: Lee Jones <lee.jones@linaro.org>
> >> ---
> >>  drivers/phy/phy-exynos-dp-video.c           |  5 ++--
> >>  drivers/phy/phy-exynos-mipi-video.c         | 39 ++++++++++++++---------------
> >>  drivers/phy/phy-exynos5-usbdrd.c            |  5 ++--
> >>  include/linux/mfd/syscon/exynos5-pmu.h      | 22 ----------------
> >>  include/linux/soc/samsung/exynos-regs-pmu.h |  3 ++-
> >>  5 files changed, 25 insertions(+), 49 deletions(-)
> >>  delete mode 100644 include/linux/mfd/syscon/exynos5-pmu.h
> >
> > [...]
> >
> >> --- a/include/linux/mfd/syscon/exynos5-pmu.h
> >> +++ /dev/null
> >
> >> -#define EXYNOS5433_PAD_RETENTION_AUD_OPTION          (0x3028)
> >> -#define EXYNOS5433_PAD_INITIATE_WAKEUP_FROM_LOWPWR   BIT(28)
> >
> > EXYNOS5433_PAD_INITIATE_WAKEUP_FROM_LOWPWR is not defined in
> > <soc/samsung/exynos-regs-pmu.h> and is still used by
> > drivers/mfd/exynos-lpass.c (at least in next-20170310)
> >
> > Do I miss something or it needs to be fixed?
> 
> Yeah, kbuild also told me that. :)
> 
> I fixed it in v3, can you take a look?
> http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1351482.html

Ah, thanks, my mailing lists retrieval setup has some lag..

For the whole v3:

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
