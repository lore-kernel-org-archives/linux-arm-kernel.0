From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sat, 10 Mar 2012 22:09:22 +0100
Subject: [GIT PULL 2/4] Samsung devel-pd for v3.4
In-Reply-To: <CAOesGMjff3gVNJQ5FpJuSf+uvVDW8k22b+Xcikot-isM-4-6iw@mail.gmail.com>
References: <4F5B7C81.6080301@samsung.com>
 <CAOesGMjff3gVNJQ5FpJuSf+uvVDW8k22b+Xcikot-isM-4-6iw@mail.gmail.com>
Message-ID: <201203102209.22451.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Saturday, March 10, 2012, Olof Johansson wrote:
> Hi Rafael,
> 
> The below series contains two patches that have been sent to you, and
> that are sitting in the pm-domains branch.
> 
> Two questions before I pull this into arm-soc:
> 
> 1) Are you 100% sure this will be submitted to 3.4? And if so, will
> you send it early during the merge window?

Yes and yes.

> 2) Are you 100% sure you will not rebase the branch into which you
> pulled the v3.4-for-rafael branch?

Yes, I am.

> I am asking because if we pull this in, and you rebase between now and
> when it's sent in, we're risking merge conflicts that will be painful
> to resolve. We've been bitten by that from other dependencies in the
> past so we're being careful.

Sure, I understand that.

As a general rule, topic braches in my tree whose names start with pm- are
never rebased (exactly for this reason).

Thanks,
Rafael


> On Sat, Mar 10, 2012 at 8:08 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Hi Arnd, Olof,
> >
> > This is Generic Power Domain patches for EXYNOS. Basically, Thomas' patches,
> > adding support Generic Power Domain patches are in Rafael's tree,
> > linux-pm/linux-next and see below merge commit.
> > http://git.kernel.org/?p=linux/kernel/git/rafael/linux-pm.git;a=commit;h=dcaad77a8074b6de58e745546bc543d5538404f2
> > And this adds hooking up G2D and JPEG to Generic PD.
> >
> > Please pull and here is my preferred resolution when merge this after
> > next/board-samsung.
> >
> > diff --cc arch/arm/mach-exynos/mach-universal_c210.c
> > index 3663aee,0262417..0b944eb
> > --- a/arch/arm/mach-exynos/mach-universal_c210.c
> > +++ b/arch/arm/mach-exynos/mach-universal_c210.c
> > @@@ -1053,10 -981,6 +1052,7 @@@ static struct platform_device *universa
> >        &s5p_device_mfc,
> >        &s5p_device_mfc_l,
> >        &s5p_device_mfc_r,
> > -       &exynos4_device_pd[PD_MFC],
> > -       &exynos4_device_pd[PD_LCD0],
> > -       &exynos4_device_pd[PD_CAM],
> >  +      &cam_vt_dio_fixed_reg_dev,
> >        &cam_i_core_fixed_reg_dev,
> >        &cam_s_if_fixed_reg_dev,
> >        &s5p_device_fimc_md,
> >
> > If any problems, please kindly let me know.
> >
> > Thanks.
> >
> > Best regards,
> > Kgene.
> > --
> > Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> > SW Solution Development Team, Samsung Electronics Co., Ltd.
> >
> > The following changes since commit 192cfd58774b4d17b2fe8bdc77d89c2ef4e0591d:
> >
> >  Linux 3.3-rc6 (2012-03-03 17:08:09 -0800)
> >
> > are available in the git repository at:
> >  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > next/devel-samsung-pd
> >
> > Sachin Kamat (2):
> >      ARM: EXYNOS: Hook up G2D PD to generic PD infrastructure
> >      ARM: EXYNOS: Hook up JPEG PD to generic PD infrastructure
> >
> > Thomas Abraham (2):
> >      PM / Domains: Add OF support
> >      ARM: EXYNOS: Hook up power domains to generic power domain
> > infrastructure
> >
> >  .../bindings/arm/exynos/power_domain.txt           |   21 ++
> >  arch/arm/mach-exynos/Kconfig                       |   10 +-
> >  arch/arm/mach-exynos/Makefile                      |    2 +-
> >  arch/arm/mach-exynos/dev-pd.c                      |  139 --------------
> >  arch/arm/mach-exynos/mach-nuri.c                   |   11 -
> >  arch/arm/mach-exynos/mach-origen.c                 |   14 --
> >  arch/arm/mach-exynos/mach-smdkv310.c               |   12 --
> >  arch/arm/mach-exynos/mach-universal_c210.c         |   17 --
> >  arch/arm/mach-exynos/pm_domains.c                  |  201
> > ++++++++++++++++++++
> >  drivers/base/power/domain.c                        |   32 +++
> >  include/linux/pm_domain.h                          |   12 ++
> >  11 files changed, 268 insertions(+), 203 deletions(-)
> >  create mode 100644
> > Documentation/devicetree/bindings/arm/exynos/power_domain.txt
> >  delete mode 100644 arch/arm/mach-exynos/dev-pd.c
> >  create mode 100644 arch/arm/mach-exynos/pm_domains.c
> 
> 
