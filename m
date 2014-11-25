From: pbonzini@redhat.com (Paolo Bonzini)
Date: Tue, 25 Nov 2014 18:05:00 +0100
Subject: [PATCH 2/7] KVM: arm: guest debug, define API headers
In-Reply-To: <1416931805-23223-3-git-send-email-alex.bennee@linaro.org>
References: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
 <1416931805-23223-3-git-send-email-alex.bennee@linaro.org>
Message-ID: <5474B6BC.2060309@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/11/2014 17:10, Alex Benn?e wrote:
> +/* Exit types which define why we did a debug exit */
> +#define KVM_DEBUG_EXIT_ERROR		0x0
> +#define KVM_DEBUG_EXIT_SINGLE_STEP	0x1
> +#define KVM_DEBUG_EXIT_SW_BKPT		0x2
> +#define KVM_DEBUG_EXIT_HW_BKPT		0x3
> +#define KVM_DEBUG_EXIT_HW_WTPT		0x4
> +
>  struct kvm_debug_exit_arch {
> +	__u64 address;
> +	__u32 exit_type;
>  };
>  

So there is no register that says "this breakpoint has triggered" or
"this watchpoint has triggered"?

Paolo
