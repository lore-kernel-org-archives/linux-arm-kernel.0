From: gleb@redhat.com (Gleb Natapov)
Date: Thu, 27 Jun 2013 09:39:05 +0300
Subject: [GIT PULL] KVM/ARM queue for 3.11
In-Reply-To: <20130626190554.GB41132@lvm>
References: <20130626190554.GB41132@lvm>
Message-ID: <20130627063905.GA18508@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 12:05:54PM -0700, Christoffer Dall wrote:
> Hi Gleb and Paolo,
> 
> The following changes since commit 87d41fb4da6467622b7a87fd6afe8071abab6dae:
> 
>   KVM: s390: Fixed priority of execution in STSI (2013-06-20 23:33:01 +0200)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/cdall/linux-kvm-arm.git tags/kvm-arm-3.11
> 
> for you to fetch changes up to 8bd4ffd6b3a98f00267051dc095076ea2ff06ea8:
> 
>   ARM: kvm: don't include drivers/virtio/Kconfig (2013-06-26 10:50:06 -0700)
> 
> 
Pulled, thanks.

> Thanks,
> -Christoffer
> 
> ----------------------------------------------------------------
> Anup Patel (1):
>       ARM: KVM: Allow host virt timer irq to be different from guest timer virt irq
> 
> Arnd Bergmann (1):
>       ARM: kvm: don't include drivers/virtio/Kconfig
> 
> Christoffer Dall (1):
>       Update MAINTAINERS: KVM/ARM work now funded by Linaro
> 
> Dave P Martin (1):
>       ARM: KVM: Don't handle PSCI calls via SMC
> 
> Geoff Levand (1):
>       arm/kvm: Cleanup KVM_ARM_MAX_VCPUS logic
> 
> Marc Zyngier (7):
>       ARM: KVM: remove dead prototype for __kvm_tlb_flush_vmid
>       ARM: KVM: use phys_addr_t instead of unsigned long long for HYP PGDs
>       ARM: KVM: don't special case PC when doing an MMIO
>       ARM: KVM: get rid of S2_PGD_SIZE
>       ARM: KVM: perform save/restore of PAR
>       ARM: KVM: add missing dsb before invalidating Stage-2 TLBs
>       ARM: KVM: clear exclusive monitor on all exception returns
> 
>  MAINTAINERS                        |  4 ++--
>  arch/arm/include/asm/kvm_arm.h     |  1 -
>  arch/arm/include/asm/kvm_asm.h     | 24 ++++++++++++------------
>  arch/arm/include/asm/kvm_emulate.h |  5 -----
>  arch/arm/include/asm/kvm_host.h    |  9 +++++++--
>  arch/arm/kvm/Kconfig               |  8 +++-----
>  arch/arm/kvm/arm.c                 |  8 ++++----
>  arch/arm/kvm/coproc.c              |  4 ++++
>  arch/arm/kvm/handle_exit.c         |  3 ---
>  arch/arm/kvm/interrupts.S          | 16 +++++++++++++++-
>  arch/arm/kvm/interrupts_head.S     | 10 ++++++++--
>  arch/arm/kvm/mmio.c                |  6 ------
>  arch/arm/kvm/mmu.c                 |  3 ---
>  arch/arm/kvm/psci.c                |  2 +-
>  arch/arm/kvm/reset.c               | 12 ++++++++++++
>  include/kvm/arm_arch_timer.h       |  4 ++++
>  virt/kvm/arm/arch_timer.c          | 29 ++++++++++++++++++++---------
>  17 files changed, 92 insertions(+), 56 deletions(-)

--
			Gleb.
