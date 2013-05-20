From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 May 2013 16:45:15 +0100
Subject: [PATCH v4 05/32] arm64: KVM: Basic ESR_EL2 helpers and vcpu
 register access
In-Reply-To: <20130520154142.GD3639@MacBook-Pro.local>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-6-git-send-email-marc.zyngier@arm.com>
 <20130520154142.GD3639@MacBook-Pro.local>
Message-ID: <519A450B.5030309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/13 16:41, Catalin Marinas wrote:
> On Tue, May 14, 2013 at 03:13:33PM +0100, Marc Zyngier wrote:
>> Implements helpers for dealing with the EL2 syndrome register as
>> well as accessing the vcpu registers.
>>
>> Reviewed-by: Christopher Covington <cov@codeaurora.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ...
>> +static inline bool kvm_vcpu_dabt_isvalid(const struct kvm_vcpu *vcpu)
>> +{
>> +	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_EL2_ISV);
>> +}
> 
> You kept these '!!' ;). BTW, would the compiler handle the conversion
> between the integer and bool here?

I like them very much. The compiler handles the conversion perfectly
fine, but the '!!' makes the intent explicit, and someone reviewing the
code won't be tempted to change the return type to u64 or something similar.

> Either way is fine by me:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
