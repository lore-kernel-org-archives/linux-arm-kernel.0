From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 27 May 2013 19:12:11 +0900
Subject: [PATCH] ARM: S5PV210: dependency issue,
 S5P_SLEEP is depend on ARM_CPU_SUSPEND
In-Reply-To: <51A32FD4.4000001@asianux.com>
References: <5199E4AF.7040607@asianux.com> <51A32FD4.4000001@asianux.com>
Message-ID: <158201ce5ac2$a7843de0$f68cb9a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chen Gang wrote:
> 
> Hello Maintainers:
> 
Hi,

> Please help check this patch whether OK, when you have time.
> 
> 
> Thanks.
> 
> On 05/20/2013 04:54 PM, Chen Gang wrote:
> >
> > When randconfig with MMU for arm s5pv210 (and select all cpu type),
> > need let S5P_SLEEP depend on ARM_CPU_SUSPEND, or will cause issue below:
> >
> >   arch/arm/plat-samsung/built-in.o: In function `s3c_cpu_resume':
> >   arch/arm/plat-samsung/s5p-sleep.S:83: undefined reference to
> `cpu_resume'
> >
> >
> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> > ---
> >  arch/arm/plat-samsung/Kconfig |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-
> samsung/Kconfig
> > index f8ed2de..1d38541 100644
> > --- a/arch/arm/plat-samsung/Kconfig
> > +++ b/arch/arm/plat-samsung/Kconfig
> > @@ -483,6 +483,7 @@ config S5P_PM
> >
> >  config S5P_SLEEP
> >  	bool
> > +	select ARM_CPU_SUSPEND

Probably,

+	select ARM_CPU_SUSPEND if PM ?

selecting the S5P_SLEEP depends on PM though...

- Kukjin
