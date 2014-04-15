From: jays.lee@samsung.com (Jungseok Lee)
Date: Tue, 15 Apr 2014 09:38:33 +0900
Subject: [PATCH 2/8] arm/arm64: KVM: Fix line length exceeding 80
 characters
In-Reply-To: <534C0A89.4090907@arm.com>
References: <000001cf57b4$d3450780$79cf1680$@samsung.com>
 <534C0A89.4090907@arm.com>
Message-ID: <001601cf5843$07c38160$174a8420$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 15, 2014 1:19 AM, Marc Zyngier wrote:
> On 14/04/14 08:40, Jungseok Lee wrote:
> > This patch deals with checkpatch complaint as fixing line length
> > exceeding 80 characters.
> >
> > WARNING: line over 80 characters
> >
> > Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
> > Reviewed-by: Sungjinn Chung <sungjinn.chung@samsung.com>
> > ---
> >  arch/arm/kvm/mmu.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c index
> > 80bb1e6..e0d4f24 100644
> > --- a/arch/arm/kvm/mmu.c
> > +++ b/arch/arm/kvm/mmu.c
> > @@ -563,8 +563,8 @@ void kvm_free_stage2_pgd(struct kvm *kvm)
> >  	kvm->arch.pgd = NULL;
> >  }
> >
> > -static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
> > -			     phys_addr_t addr)
> > +static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache
> > +			     *cache, phys_addr_t addr)
> 
> Please don't. This makes the code unreadable (and no, I don't care about checkpatch ;-).

Okay. I will drop this patch from the next version.

It would be good to change stage2_set_pmd_huge function for readability
if you don't care about checkpatch.

Best Regards
Jungseok Lee
