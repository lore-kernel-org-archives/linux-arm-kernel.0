From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 May 2013 15:30:16 +0100
Subject: [PATCH v4 14/32] arm64: KVM: guest one-reg interface
In-Reply-To: <1368540840-26750-15-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-15-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130521143015.GF27002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 03:13:42PM +0100, Marc Zyngier wrote:
> Let userspace play with the guest registers.
> 
> Reviewed-by: Christopher Covington <cov@codeaurora.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> --- /dev/null
> +++ b/arch/arm64/kvm/guest.c
...
> +static int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> +{
> +	__u32 __user *uaddr = (__u32 __user *)(unsigned long)reg->addr;
> +	struct kvm_regs *regs = vcpu_gp_regs(vcpu);
> +	int nr_regs = sizeof(*regs) / sizeof(__u32);

Was there any conclusion on using __u32 rather than __u64 here? At least
you should add a comment since it's slightly confusing.

-- 
Catalin
