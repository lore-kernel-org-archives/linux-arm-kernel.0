From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 11 Dec 2014 10:47:17 +0100
Subject: [GIT PULL 0/9] KVM/ARM Changes for v3.19
In-Reply-To: <54874FFB.40306@redhat.com>
References: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
 <54874FFB.40306@redhat.com>
Message-ID: <20141211094717.GB28388@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 09, 2014 at 08:39:39PM +0100, Paolo Bonzini wrote:
> 
> 
> On 09/12/2014 12:25, Christoffer Dall wrote:
> > Hi Paolo,
> > 
> > The following changes since commit f62c95fd4041d669159dd76ac0bb2a7f86b5b05d:
> > 
> >   Merge tag 'kvm-s390-next-20141028' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD (2014-10-29 13:31:32 +0100)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git kvm-arm-for-3.19
> > 
> > for you to fetch changes up to 016ed39c54b8a3db680e5c6a43419f806133caf2:
> > 
> >   arm/arm64: KVM: vgic: kick the specific vcpu instead of iterating through all (2014-11-26 10:19:37 +0000)
> > 
> > Thanks,
> > -Christoffer
> > 
> > ----------------------------------------------------------------
> > Changes for KVM for arm/arm64 for v3.19 including mmio mapping fixups
> > (already in kvm/next, apologies about duplicate commits), vgic cleanup
> > and optimizations, and an MMIO path cleanup.
> > 
> > ----------------------------------------------------------------
> > 
> > 
> > Andre Przywara (1):
> >   arm/arm64: KVM: avoid unnecessary guest register mangling on MMIO read
> > 
> > Ard Biesheuvel (4):
> >   arm/arm64: kvm: drop inappropriate use of kvm_is_mmio_pfn()
> >   kvm: fix kvm_is_mmio_pfn() and rename to kvm_is_reserved_pfn()
> >   kvm: add a memslot flag for incoherent memory regions
> >   arm, arm64: KVM: handle potential incoherency of readonly memslots
> > 
> > Christoffer Dall (1):
> >   arm/arm64: vgic: Remove unreachable irq_clear_pending
> > 
> > Laszlo Ersek (1):
> >   arm, arm64: KVM: allow forced dcache flush on page faults
> > 
> > Shannon Zhao (1):
> >   arm/arm64: KVM: vgic: kick the specific vcpu instead of iterating
> >     through all
> > 
> > wanghaibin (1):
> >   KVM: ARM: VGIC: Optimize the vGIC vgic_update_irq_pending function.
> > 
> >  arch/arm/include/asm/kvm_mmu.h   |  5 +++--
> >  arch/arm/kvm/mmio.c              | 15 +++++++++------
> >  arch/arm/kvm/mmu.c               | 34 +++++++++++++++++++++++++++-------
> >  arch/arm64/include/asm/kvm_mmu.h |  5 +++--
> >  arch/ia64/kvm/kvm-ia64.c         |  2 +-
> >  arch/x86/kvm/mmu.c               |  6 +++---
> >  include/linux/kvm_host.h         |  3 ++-
> >  virt/kvm/arm/vgic.c              | 20 +++++++++++++-------
> >  virt/kvm/kvm_main.c              | 16 ++++++++--------
> >  9 files changed, 69 insertions(+), 37 deletions(-)
> > 
> 
> No dirty bitmap yet?  You still have one week, I'm okay with a late
> addition.
> 
No, we spotted a bug in the last revision and I prefer not merging it at
this short notice, because I won't have proper time to test the stuff.

The plan is to put it in kvmarm/next right after the merge window
closes.

-Christoffer
