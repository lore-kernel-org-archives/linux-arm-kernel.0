From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 May 2013 16:41:43 +0100
Subject: [PATCH v4 05/32] arm64: KVM: Basic ESR_EL2 helpers and vcpu
 register access
In-Reply-To: <1368540840-26750-6-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130520154142.GD3639@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 03:13:33PM +0100, Marc Zyngier wrote:
> Implements helpers for dealing with the EL2 syndrome register as
> well as accessing the vcpu registers.
> 
> Reviewed-by: Christopher Covington <cov@codeaurora.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
...
> +static inline bool kvm_vcpu_dabt_isvalid(const struct kvm_vcpu *vcpu)
> +{
> +	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_EL2_ISV);
> +}

You kept these '!!' ;). BTW, would the compiler handle the conversion
between the integer and bool here?

Either way is fine by me:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
