From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 27 Sep 2012 10:10:59 +0100
Subject: [PULL] HYP-mode boot
In-Reply-To: <c65993c242ac431861fb90dbd94e0057@localhost>
References: <c65993c242ac431861fb90dbd94e0057@localhost>
Message-ID: <50641823.2050302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/09/12 08:55, Marc Zyngier wrote:

Hi Russell,

> Could you please pull the following branch into your tree? It contains the
> HYP-mode boot code, which has been posted twice on LAK, and has been
> heavily used for KVM.
> 
> It is based on your opcodes branch.

Any update on this?

Cheers,

	M.

> The following changes since commit
> 508514ed25315dd28340000831b17535d6f772da:
> 
>   ARM: 7511/1: opcodes: Opcode definitions for the Virtualization
> Extensions (2012-09-15 21:26:00 +0100)
> 
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
> hyp-boot-mode-rmk
> 
> Dave Martin (5):
>       ARM: virt: allow the kernel to be entered in HYP mode
>       ARM: zImage/virt: hyp mode entry support for the zImage loader
>       ARM: virt: Update documentation for hyp mode entry support
>       ARM: virt: Add boot-time diagnostics
>       ARM: virt: Add CONFIG_ARM_VIRT_EXT option
> 
> Marc Zyngier (2):
>       ARM: opcodes: add __ERET/__MSR_ELR_HYP instruction encoding
>       ARM: virt: arch_timers: enable access to physical timers
> 
>  Documentation/arm/Booting           |   22 ++++-
>  arch/arm/boot/compressed/.gitignore |    1 +
>  arch/arm/boot/compressed/Makefile   |    9 ++-
>  arch/arm/boot/compressed/head.S     |   71 ++++++++++-
>  arch/arm/include/asm/assembler.h    |   28 +++++
>  arch/arm/include/asm/opcodes-virt.h |   10 ++
>  arch/arm/include/asm/ptrace.h       |    1 +
>  arch/arm/include/asm/virt.h         |   69 +++++++++++
>  arch/arm/kernel/Makefile            |    2 +
>  arch/arm/kernel/head.S              |   14 ++-
>  arch/arm/kernel/hyp-stub.S          |  223
> +++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/setup.c             |   20 +++
>  arch/arm/kernel/smp.c               |    3 +
>  arch/arm/mm/Kconfig                 |   17 +++
>  14 files changed, 478 insertions(+), 12 deletions(-)
>  create mode 100644 arch/arm/include/asm/virt.h
>  create mode 100644 arch/arm/kernel/hyp-stub.S
> 


-- 
Jazz is not dead. It just smells funny...
