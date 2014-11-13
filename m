From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 13 Nov 2014 13:42:23 +0900
Subject: [PATCH] ARM: EXYNOS: fix typo in static struct name
 "exynos5_list_diable_wfi_wfe"
In-Reply-To: <000d01cffefa$3688d550$a39a7ff0$@samsung.com>
References: <1414489832-28011-1-git-send-email-pankaj.dubey@samsung.com>
 <CABxcv=nJ7-NoF-0EqCL=rk6hX2688iV98g=CiDADKT7QTNWBrw@mail.gmail.com>
 <CABxcv==Hjfi+-Mt63YQaCtC3Wj12WFfU6biwmiVEFQvqAp3DBA@mail.gmail.com>
 <54641A05.9030107@samsung.com> <000d01cffefa$3688d550$a39a7ff0$@samsung.com>
Message-ID: <029b01cffefc$3aa68900$aff39b00$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pankaj Dubey wrote:
> 
> Hi Kukijin,
> 
Hi,

> On Thursday, November 13, 2014 8:10 AM, Kukjin Kim wrote:
> > Subject: Re: [PATCH] ARM: EXYNOS: fix typo in static struct name
> > "exynos5_list_diable_wfi_wfe"
> >
> > On 11/11/14 18:54, Javier Martinez Canillas wrote:
> > > Hello Kukjin,
> > >
> > >>
> > >> After this patch, "[PATCH v9 1/2] ARM: EXYNOS: Add platform driver
> > >> support for Exynos PMU" [0] does not apply cleanly anymore.
> > >>
> > >
> > > I see that you already picked all the Exynos S2R patches on your
> > > v3.19-next/mach-exynos branch and also resolved that conflict.
> > >
> > Yes, but I couldn't merge it into -next because of some conflicts between
> for-next and
> > mach-exynos branch at that time.
> >
> > Note I've merged into -next just now, so if any problems in -next, please
> let us know.
> >
> 
> I just checked and your for-next failed to compile for exynos_defconfig. I
> got following error:
> ----------
> <stdin>:1247:2: warning: #warning syscall bpf not implemented [-Wcpp]
>   CHK     include/generated/compile.h
>   CC      arch/arm/mach-exynos/platsmp.o
> arch/arm/mach-exynos/platsmp.c:448:13: error: static declaration of
> 'exynos_cpu_die' follows non-static declaration
>  static void exynos_cpu_die(unsigned int cpu)
>              ^
> In file included from arch/arm/mach-exynos/platsmp.c:32:0:
> arch/arm/mach-exynos/common.h:142:13: note: previous declaration of
> 'exynos_cpu_die' was here
>  extern void exynos_cpu_die(unsigned int cpu);
>              ^
> make[1]: *** [arch/arm/mach-exynos/platsmp.o] Error 1
> make: *** [arch/arm/mach-exynos] Error 2
> make: *** Waiting for unfinished jobs....
> --------------------------
> 
> With following fix I am able to build the for-next.
> ----------------------------------------------------------------------------
> --
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index 2ce225b..472417c 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -139,7 +139,6 @@ extern struct smp_operations exynos_smp_ops;
>  extern void exynos_cpu_resume(void);
>  extern void exynos_cpu_resume_ns(void);
> 
> -extern void exynos_cpu_die(unsigned int cpu);
>  extern void exynos_cpu_power_down(int cpu);
>  extern void exynos_cpu_power_up(int cpu);
>  extern int  exynos_cpu_power_state(int cpu);
> -------------------------------------------------------------------------
> 
> Let me know if I have to do something? else please update according to
> above change.
> 
Oops, it's my mistake. I'll fix it up as soon as possible...

Thanks,
Kukjin
