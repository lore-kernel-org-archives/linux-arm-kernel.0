From: n.nikolaev@virtualopensystems.com (Nikolay Nikolaev)
Date: Sat, 29 Nov 2014 15:49:37 +0200
Subject: [RFC PATCH 4/5] ARM: enable linking against eventfd and irqchip
In-Reply-To: <54797337.2050001@huawei.com>
References: <20141124212240.10605.46770.stgit@i3820>
 <20141124212706.10605.50148.stgit@i3820>
 <54797337.2050001@huawei.com>
Message-ID: <CADDJ2=PoUa+ZNJ8grvZondPYQX31sZkGWxM9Jq7BN0JT9w_kXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 29, 2014 at 9:18 AM, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
>
> On 2014/11/25 5:27, Nikolay Nikolaev wrote:
> > This enables compilation of the eventfd feature on ARM.
> >
>
> Only enable on ARM? I think we should enable it on ARM64 as well because the eventfd featrue is common for ARM32 and ARM64.

If course - thanks for pointing this out.

regards,
Nikolay Nikolaev
>
> Thanks,
> Shannon
>
> > Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
> > ---
> >  arch/arm/kvm/Kconfig  |    1 +
> >  arch/arm/kvm/Makefile |    2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> > index 466bd29..a4b0312 100644
> > --- a/arch/arm/kvm/Kconfig
> > +++ b/arch/arm/kvm/Kconfig
> > @@ -20,6 +20,7 @@ config KVM
> >       bool "Kernel-based Virtual Machine (KVM) support"
> >       select PREEMPT_NOTIFIERS
> >       select ANON_INODES
> > +     select HAVE_KVM_EVENTFD
> >       select HAVE_KVM_CPU_RELAX_INTERCEPT
> >       select KVM_MMIO
> >       select KVM_ARM_HOST
> > diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
> > index 443b8be..539c1a5 100644
> > --- a/arch/arm/kvm/Makefile
> > +++ b/arch/arm/kvm/Makefile
> > @@ -15,7 +15,7 @@ AFLAGS_init.o := -Wa,-march=armv7-a$(plus_virt)
> >  AFLAGS_interrupts.o := -Wa,-march=armv7-a$(plus_virt)
> >
> >  KVM := ../../../virt/kvm
> > -kvm-arm-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o
> > +kvm-arm-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o
> >
> >  obj-y += kvm-arm.o init.o interrupts.o
> >  obj-y += arm.o handle_exit.o guest.o mmu.o emulate.o reset.o
> >
> > _______________________________________________
> > kvmarm mailing list
> > kvmarm at lists.cs.columbia.edu
> > https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> >
> >
>
