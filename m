From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Nov 2018 15:38:20 +0000
Subject: [PATCH 2/2] arm64: defconfig: enable BPF related configs
In-Reply-To: <CAKv+Gu9EE_bWcoxEFr4pi41pfAQsDAywKR+gSueA9vE_Z4Np+g@mail.gmail.com>
References: <20181111181048.10933-1-pbrobinson@gmail.com>
 <20181111181048.10933-2-pbrobinson@gmail.com>
 <20181112183623.GA2265@brain-police>
 <CAKv+Gu9EE_bWcoxEFr4pi41pfAQsDAywKR+gSueA9vE_Z4Np+g@mail.gmail.com>
Message-ID: <20181126153820.GA28400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 17, 2018 at 03:18:04PM -0800, Ard Biesheuvel wrote:
> On Mon, 12 Nov 2018 at 10:36, Will Deacon <will.deacon@arm.com> wrote:
> > On Sun, Nov 11, 2018 at 06:10:48PM +0000, Peter Robinson wrote:
> > > The BPF components are getting more widely used by various components
> > > so we should enable them in the ARMv7 multi config to ensure they
> > > get wider testing and don't regress.
> >
> > Have other architectures already made this leap?
> >
> 
> $ git grep CONFIG_BPF_SYSCALL=y arch/
> arch/arm/configs/aspeed_g4_defconfig:CONFIG_BPF_SYSCALL=y
> arch/arm/configs/aspeed_g5_defconfig:CONFIG_BPF_SYSCALL=y
> arch/mips/configs/generic_defconfig:CONFIG_BPF_SYSCALL=y
> arch/powerpc/configs/44x/fsp2_defconfig:CONFIG_BPF_SYSCALL=y
> arch/powerpc/configs/powernv_defconfig:CONFIG_BPF_SYSCALL=y
> arch/powerpc/configs/ppc64_defconfig:CONFIG_BPF_SYSCALL=y
> arch/powerpc/configs/pseries_defconfig:CONFIG_BPF_SYSCALL=y
> arch/riscv/configs/defconfig:CONFIG_BPF_SYSCALL=y
> arch/s390/configs/debug_defconfig:CONFIG_BPF_SYSCALL=y
> arch/s390/configs/performance_defconfig:CONFIG_BPF_SYSCALL=y
> arch/s390/defconfig:CONFIG_BPF_SYSCALL=y
> 
> but nobody seems to enable CONFIG_BPF_JIT_ALWAYS_ON.
> 
> I sent some patches to move the BPF JIT allocations out of the module
> range. Whether that really improves things in terms of security is not
> obvious to me, but at least we stop wasting module region space (and
> potentially KASAN shadow pages) on BPF programs.
> 
> If this is mainly for coverage, it would indeed be nice if we could at
> least make it root only by default. However, if the distros are
> enabling this in their default configurations, I'd prefer it if we at
> least have a config that will help us spot issues early on.

That's a fair point on the distros. Peter, as author of the patch, please
can you take a look at the arm64 kernel configs from some popular
distributions and see which of these options they tend to enable?

Thanks,

Will
