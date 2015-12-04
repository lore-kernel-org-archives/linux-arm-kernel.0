From: pbonzini@redhat.com (Paolo Bonzini)
Date: Fri, 4 Dec 2015 18:39:08 +0100
Subject: [GIT PULL] KVM/ARM fixes for 4.4-rc4
In-Reply-To: <1449249440-28878-1-git-send-email-marc.zyngier@arm.com>
References: <1449249440-28878-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <5661CFBC.3030601@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/12/2015 18:17, Marc Zyngier wrote:
> Hi Paolo,
> 
> This pull request contains a number of fixes for 4.4-rc4 (or -rc5 if
> we already missed the boat).
> 
> The first part is a very nice catch from Pavel, who noticed that we
> were not dealing very well (if at all) with the aliasing between two
> registers.
> 
> The last patch from Ard is a fix for a fix that was merged in
> -rc3. Hopefully we got it right this time.
> 
> Please pull!
> 
>        M.
> 
> The following changes since commit fbb4574ce9a37e15a9872860bf202f2be5bdf6c4:
> 
>   arm64: kvm: report original PAR_EL1 upon panic (2015-11-24 18:20:58 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-v4.4-rc4
> 
> for you to fetch changes up to 0de58f852875a0f0dcfb120bb8433e4e73c7803b:
> 
>   ARM/arm64: KVM: correct PTE uncachedness check (2015-12-04 16:30:17 +0000)
> 
> ----------------------------------------------------------------
> KVM/ARM fixes for v4.4-rc4
> 
> - A series of fixes to deal with the aliasing between the sp and xzr register
> - A fix for the cache flush fix that went in -rc3
> 
> ----------------------------------------------------------------
> Ard Biesheuvel (1):
>       ARM/arm64: KVM: correct PTE uncachedness check
> 
> Pavel Fedin (4):
>       arm64: KVM: Correctly handle zero register during MMIO
>       arm64: KVM: Remove const from struct sys_reg_params
>       arm64: KVM: Correctly handle zero register in system register accesses
>       arm64: KVM: Get rid of old vcpu_reg()
> 
>  arch/arm/include/asm/kvm_emulate.h   |  12 ++++
>  arch/arm/kvm/mmio.c                  |   5 +-
>  arch/arm/kvm/mmu.c                   |   4 +-
>  arch/arm/kvm/psci.c                  |  20 +++---
>  arch/arm64/include/asm/kvm_emulate.h |  18 +++--
>  arch/arm64/kvm/handle_exit.c         |   2 +-
>  arch/arm64/kvm/sys_regs.c            | 123 +++++++++++++++++------------------
>  arch/arm64/kvm/sys_regs.h            |   8 +--
>  arch/arm64/kvm/sys_regs_generic_v8.c |   4 +-
>  9 files changed, 107 insertions(+), 89 deletions(-)
> 

Pulled, thanks.

Paolo
