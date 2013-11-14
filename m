From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 14 Nov 2013 16:06:33 +0100
Subject: [RFC 0/4] Add basic support for ASV
In-Reply-To: <CAKew6eUK9ZtoVgVu_b13Bn20iMNWzHnWjSHMjxD1Y+zDtvoCWw@mail.gmail.com>
References: <1378898048-25205-1-git-send-email-yadi.brar@samsung.com>
 <CAKew6eUK9ZtoVgVu_b13Bn20iMNWzHnWjSHMjxD1Y+zDtvoCWw@mail.gmail.com>
Message-ID: <1906951.EFsdgbeaob@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yadwinder,

On Monday 11 of November 2013 23:27:08 Yadwinder Singh Brar wrote:
> gentle ping for suggestions/reviews ..

Hmm, I must have somehow missed this series when you orignally sent it.
Can I ask you to resend it, as I don't have it in my e-mail client archive
any longer?

While at it, I would also ask you to add my private e-mail address 
(this one) and linux-pm mailing list to Cc list.

Thanks in advance.

Best regards,
Tomasz

> 
> 
> On Wed, Sep 11, 2013 at 8:14 PM, Yadwinder Singh Brar
> <yadi.brar@samsung.com> wrote:
> > This series is to add basic common infrastructure for ASV.
> >  Basically ASV is a technique used on samsung SoCs, which provides the
> > recommended supply voltage for dvfs of arm, mif etc. For a given operating
> > frequency, the voltage is recommended based on SoC's ASV group.
> > ASV group gets fussed on SoCs during process of mass production.
> >
> > This series includes:
> >  - basic common infrastructue for ASV. It provides common APIs for user drivers
> > like cpufreq & devfreq and and an interface for SoC specific drivers to
> > register ASV members(instances)
> >  - a common platform driver to register ASV members for exynos SoCs
> >  - an example providing minimal support (only for ARM ASV) for exynos5250 chips
> >
> > Its just basic skelton which I wanted to get it reviewed or discussed in
> > early stage, before going ahead on further development based on it.
> >  Presently example is based on static ASV table provided in SoC specific file,
> > which I expects to go into DT. But exactly how and where needs to be discussed,
> > may be in next revisions once we get through the basic skelton.
> >  Also the location of driver in kernel may also seem odd to someone and
> > many more things :).
> >
> > Looking for your valuable reviews and suggestions.
> >
> > Thanks
> >
> > Yadwinder Singh Brar (4):
> >   power: asv: Add common ASV support for samsung SoCs
> >   power: asv: Add a common asv driver for exynos SoCs.
> >   power: asv: Add support for exynos5250
> >   arm: exynos5: Register static platform device for ASV.
> >
> >  arch/arm/mach-exynos/mach-exynos5-dt.c   |    3 +
> >  drivers/power/Kconfig                    |    1 +
> >  drivers/power/Makefile                   |    1 +
> >  drivers/power/asv/Kconfig                |   24 ++++
> >  drivers/power/asv/Makefile               |    2 +
> >  drivers/power/asv/exynos-asv.c           |   81 ++++++++++++++
> >  drivers/power/asv/exynos-asv.h           |   22 ++++
> >  drivers/power/asv/exynos5250-asv.c       |  141 ++++++++++++++++++++++++
> >  drivers/power/asv/samsung-asv.c          |  175 ++++++++++++++++++++++++++++++
> >  include/linux/power/samsung-asv-driver.h |   61 +++++++++++
> >  include/linux/power/samsung-asv.h        |   37 +++++++
> >  11 files changed, 548 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/power/asv/Kconfig
> >  create mode 100644 drivers/power/asv/Makefile
> >  create mode 100644 drivers/power/asv/exynos-asv.c
> >  create mode 100644 drivers/power/asv/exynos-asv.h
> >  create mode 100644 drivers/power/asv/exynos5250-asv.c
> >  create mode 100644 drivers/power/asv/samsung-asv.c
> >  create mode 100644 include/linux/power/samsung-asv-driver.h
> >  create mode 100644 include/linux/power/samsung-asv.h
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
