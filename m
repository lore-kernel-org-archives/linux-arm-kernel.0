From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Oct 2010 16:28:11 +0900
Subject: [PATCH V3 2/3] ARM: S5PV310: Remove L2 cache init in machine
In-Reply-To: <004601cb70f0$ce0558f0$6a100ad0$@com>
References: <1287643483-16046-1-git-send-email-kgene.kim@samsung.com>
	<1287643483-16046-3-git-send-email-kgene.kim@samsung.com>
	<004601cb70f0$ce0558f0$6a100ad0$@com>
Message-ID: <033601cb70f1$85cbb420$91631c60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daein Moon wrote:
> 
> Kukjin Kim wrote:
> > From: Kyungmin Park <kyungmin.park@samsung.com>
> >
> > Basically, need L2 cache initialize function in ARCH_S5PV310. So it
would
> > be better to move it into ARCH_S5PV310 common part. This patch removes
L2
> > cache initialization code at the each board file.
> >
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> >  arch/arm/mach-s5pv310/mach-smdkc210.c       |    4 ----
> >  arch/arm/mach-s5pv310/mach-smdkv310.c       |    4 ----
> >  arch/arm/mach-s5pv310/mach-universal_c210.c |    4 ----
> >  3 files changed, 0 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm/mach-s5pv310/mach-smdkc210.c b/arch/arm/mach-
> > s5pv310/mach-smdkc210.c
> > index 93d537b..3cde5ed 100644
> > --- a/arch/arm/mach-s5pv310/mach-smdkc210.c
> > +++ b/arch/arm/mach-s5pv310/mach-smdkc210.c
> > @@ -129,10 +129,6 @@ static void __init smdkc210_machine_init(void)
> >  	s3c_sdhci2_set_platdata(&smdkc210_hsmmc2_pdata);
> >  	s3c_sdhci3_set_platdata(&smdkc210_hsmmc3_pdata);
> >
> > -#ifdef CONFIG_CACHE_L2X0
> > -	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
> > -#endif
> > -
> Hi,
> 
> If L2 cache init is removed, including header file
> "asm/hardware/cache-l2x0.h" isn't needed.
> 
Yes, you're right...will be removed.

Thanks for your pointing out.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
