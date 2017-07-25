From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 25 Jul 2017 14:36:14 +0100
Subject: [PATCH] KVM: arm/arm64: Fix guest external abort matching
In-Reply-To: <20170718123741.11537-1-james.morse@arm.com>
References: <20170718123741.11537-1-james.morse@arm.com>
Message-ID: <b884d460-2e01-5db9-123b-58a88c03e388@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/17 13:37, James Morse wrote:
> The ARM-ARM has two bits in the ESR/HSR relevant to external aborts.
> A range of {I,D}FSC values (of which bit 5 is always set) and bit 9 'EA'
> which provides:
>> an IMPLEMENTATION DEFINED classification of External Aborts.
> 
> This bit is in addition to the {I,D}FSC range, and has an implementation
> defined meaning. KVM should always ignore this bit when handling external
> aborts from a guest.
> 
> Remove the ESR_ELx_EA definition and rewrite its helper
> kvm_vcpu_dabt_isextabt() to check the {I,D}FSC range. This merges
> kvm_vcpu_dabt_isextabt() and the recently added is_abort_sea() helper.
> 
> Reported-by: gengdongjiu <gengdj.1984@gmail.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> CC: gengdongjiu <gengdj.1984@gmail.com>
> CC: Tyler Baicar <tbaicar@codeaurora.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
