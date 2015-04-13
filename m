From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 13 Apr 2015 14:12:31 +0200
Subject: [PATCH v2 04/10] KVM: arm: guest debug, add stub
 KVM_SET_GUEST_DEBUG ioctl
In-Reply-To: <1427814488-28467-5-git-send-email-alex.bennee@linaro.org>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
 <1427814488-28467-5-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150413121231.GO6186@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 04:08:02PM +0100, Alex Benn?e wrote:
> This commit adds a stub function to support the KVM_SET_GUEST_DEBUG
> ioctl. Currently any operation flag will return EINVAL. Actual
> functionality will be added with further patches.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>.
> 
> ---
> v2
>   - simplified form of the ioctl (stuff will go into setup_debug)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index b112efc..06c5064 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2604,7 +2604,7 @@ handled.
>  4.87 KVM_SET_GUEST_DEBUG
>  
>  Capability: KVM_CAP_SET_GUEST_DEBUG
> -Architectures: x86, s390, ppc
> +Architectures: x86, s390, ppc, arm64
>  Type: vcpu ioctl
>  Parameters: struct kvm_guest_debug (in)
>  Returns: 0 on success; -1 on error
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 5560f74..445933d 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -183,6 +183,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_ARM_PSCI:
>  	case KVM_CAP_ARM_PSCI_0_2:
>  	case KVM_CAP_READONLY_MEM:
> +	case KVM_CAP_SET_GUEST_DEBUG:
>  		r = 1;
>  		break;

shouldn't you wait with advertising this capability until you've
implemented support for it?


Thanks,
-Christoffer
