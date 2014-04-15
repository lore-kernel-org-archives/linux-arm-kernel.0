From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Apr 2014 09:11:05 +0100
Subject: [PATCH 2/8] arm/arm64: KVM: Fix line length exceeding 80
 characters
In-Reply-To: <001601cf5843$07c38160$174a8420$@samsung.com>
References: <000001cf57b4$d3450780$79cf1680$@samsung.com>
 <534C0A89.4090907@arm.com> <001601cf5843$07c38160$174a8420$@samsung.com>
Message-ID: <534CE999.10209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/04/14 01:38, Jungseok Lee wrote:
> On Tuesday, April 15, 2014 1:19 AM, Marc Zyngier wrote:
>> On 14/04/14 08:40, Jungseok Lee wrote:
>>> This patch deals with checkpatch complaint as fixing line length
>>> exceeding 80 characters.
>>>
>>> WARNING: line over 80 characters
>>>
>>> Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
>>> Reviewed-by: Sungjinn Chung <sungjinn.chung@samsung.com>
>>> ---
>>>  arch/arm/kvm/mmu.c |    4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c index
>>> 80bb1e6..e0d4f24 100644
>>> --- a/arch/arm/kvm/mmu.c
>>> +++ b/arch/arm/kvm/mmu.c
>>> @@ -563,8 +563,8 @@ void kvm_free_stage2_pgd(struct kvm *kvm)
>>>  	kvm->arch.pgd = NULL;
>>>  }
>>>
>>> -static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
>>> -			     phys_addr_t addr)
>>> +static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache
>>> +			     *cache, phys_addr_t addr)
>>
>> Please don't. This makes the code unreadable (and no, I don't care about checkpatch ;-).
> 
> Okay. I will drop this patch from the next version.
> 
> It would be good to change stage2_set_pmd_huge function for readability
> if you don't care about checkpatch.

We usually don't change that kind of thing just for the sake of changing
it. It feels like fairly pointless churn. *IF* someone happens to rework
that code, then they're welcome to fix it.

	M.
-- 
Jazz is not dead. It just smells funny...
