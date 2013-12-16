From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 16 Dec 2013 17:15:08 +0100
Subject: [PATCH 1/2] ARM: EXYNOS: Support Suspend-to-RAM on EXYNOS5420
In-Reply-To: <CANacCWx7YV45mVK=7BJjc95cSgm6ck1qSMRsfW3oeGxLC1LC5w@mail.gmail.com>
References: <1387195271-3613-1-git-send-email-a.kesavan@samsung.com>
 <CANacCWx7YV45mVK=7BJjc95cSgm6ck1qSMRsfW3oeGxLC1LC5w@mail.gmail.com>
Message-ID: <1470279.CK35gJZeX3@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 16 of December 2013 08:27:17 Vaibhav Bedia wrote:
> Hi,
> 
> On Mon, Dec 16, 2013 at 7:01 AM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
[snip]
> > +       { EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,                   { 0x0, 0x0, 0x0} },
> > +       { EXYNOS5_CMU_RESET_ISP_SYS_PWR_REG,                    { 0x0, 0x0, 0x0} },
> > +       { EXYNOS5_CMU_RESET_MFC_SYS_PWR_REG,                    { 0x0, 0x0, 0x0} },
> > +       { EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,                    { 0x0, 0x0, 0x0} },
> > +       { EXYNOS5420_CMU_RESET_DISP1_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> > +       { EXYNOS5420_CMU_RESET_MAU_SYS_PWR_REG,                 { 0x0, 0x0, 0x0} },
> > +       { EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG,                 { 0x0, 0x0, 0x0} },
> > +       { EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG,                 { 0x0, 0x0, 0x0} },
> > +       { EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG,                { 0x0, 0x0, 0x0} },
> > +       { PMU_TABLE_END,},
> > +};
> > +
> 
> Looking at a rather long list of register defines and soc_is_* checks here
> makes me wonder how this is any different from the static data that the
> other SoC vendors (TI) are trying very hard to move out of arch/arm...

Well, this data will eventually get moved to a PMU driver once
drivers/syslib (as discussed on KS in Edinburgh) infrastructure shows up.

We can't get rid of these data from kernel sources, since there is no
other place where they would fit. (No, DT is not such place.)

Best regards,
Tomasz
