From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 29 Apr 2013 17:26:52 +0100
Subject: [PATCH v3 07/32] arm64: KVM: fault injection into a guest
In-Reply-To: <1365437854-30214-8-git-send-email-marc.zyngier@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-8-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130429162652.GA16544@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 05:17:09PM +0100, Marc Zyngier wrote:
> +static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr)
> +{
> +	unsigned long cpsr = *vcpu_cpsr(vcpu);
> +	int is_aarch32;
> +	u32 esr = 0;
> +
> +	is_aarch32 = vcpu_mode_is_32bit(vcpu);

Minor thing - use bool here to match the function definition?

-- 
Catalin
