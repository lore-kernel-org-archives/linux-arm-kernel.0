From: geoff@infradead.org (Geoff Levand)
Date: Fri, 15 Mar 2013 17:55:56 -0700
Subject: [PATCH 05/29] arm64: KVM: Basic ESR_EL2 helpers and vcpu
 register access
In-Reply-To: <1362455265-24165-6-git-send-email-marc.zyngier@arm.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <1363395356.3155.84.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Tue, 2013-03-05 at 03:47 +0000, Marc Zyngier wrote:
> --- /dev/null
> +++ b/arch/arm64/include/asm/kvm_emulate.h
...

> +static inline bool vcpu_mode_is_32bit(struct kvm_vcpu *vcpu)
> +{
> +	return false;	/* 32bit? Bahhh... */
> +}
> +
> +static inline bool kvm_condition_valid(struct kvm_vcpu *vcpu)
> +{
> +	return true;	/* No conditionals on arm64 */
> +}


Does it make sense to have these routines take a const object?

  static inline bool vcpu_mode_is_32bit(struct kvm_vcpu const *vcpu)

-Geoff
