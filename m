From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 30 Jul 2015 16:15:08 +0800
Subject: [PATCH v4 2/2] arm64: Enable Marvell Berlin SoC family in
 Kconfig and defconfig
In-Reply-To: <55B9DB50.3070907@gmail.com>
References: <1437557992-7111-1-git-send-email-jszhang@marvell.com>
 <1437557992-7111-3-git-send-email-jszhang@marvell.com>
 <55B9DB50.3070907@gmail.com>
Message-ID: <20150730161508.7efb0174@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian,

On Thu, 30 Jul 2015 10:07:44 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> On 07/22/2015 11:39 AM, Jisheng Zhang wrote:
> > This patch introduces ARCH_BERLIN to enable Marvell Berlin SoC family in
> > Kconfig and defconfig.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> 
> I guess this will go through arm64 directly? If so,

I dunno. But from previous pull request for mt8173, rk3368, their according
change goes through arm-soc tree.

Thanks,
Jisheng

> 
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> 
> > ---
> >   arch/arm64/Kconfig.platforms | 6 ++++++
> >   arch/arm64/configs/defconfig | 1 +
> >   2 files changed, 7 insertions(+)
> >
> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> > index f7e4327..37b8fc5 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -1,5 +1,11 @@
> >   menu "Platform selection"
> >
> > +config ARCH_BERLIN
> > +	bool "Marvell Berlin SoC Family"
> > +	select DW_APB_ICTL
> > +	help
> > +	  This enables support for Marvell Berlin SoC Family
> > +
> >   config ARCH_EXYNOS
> >   	bool
> >   	help
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 506b466..83843f9 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -31,6 +31,7 @@ CONFIG_MODULES=y
> >   CONFIG_MODULE_UNLOAD=y
> >   # CONFIG_BLK_DEV_BSG is not set
> >   # CONFIG_IOSCHED_DEADLINE is not set
> > +CONFIG_ARCH_BERLIN=y
> >   CONFIG_ARCH_EXYNOS7=y
> >   CONFIG_ARCH_FSL_LS2085A=y
> >   CONFIG_ARCH_HISI=y
> >
