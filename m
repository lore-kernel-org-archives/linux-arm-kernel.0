From: pbonzini@redhat.com (Paolo Bonzini)
Date: Wed, 8 Jul 2015 19:14:50 +0200
Subject: [PATCH 07/13] arm64: KVM: VHE: Patch out use of HVC
In-Reply-To: <1436372356-30410-8-git-send-email-marc.zyngier@arm.com>
References: <1436372356-30410-1-git-send-email-marc.zyngier@arm.com>
 <1436372356-30410-8-git-send-email-marc.zyngier@arm.com>
Message-ID: <559D5A8A.4030901@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/07/2015 18:19, Marc Zyngier wrote:
> +/* Hack to allow stringification of macros... */
> +#define __S__(a,args...)	__stringify(a, ##args)
> +#define _S_(a,args...)		__S__(a, args)
> +
> +.macro ifnvhe nonvhe vhe
> +	alternative_insn	"\nonvhe", "\vhe", ARM64_HAS_VIRT_HOST_EXTN
> +.endm

Why not use this in patch 6 too?

Paolo
