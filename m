From: cdall@linaro.org (Christoffer Dall)
Date: Thu, 23 Feb 2017 11:10:27 +0100
Subject: [PATCH V2 1/2] KVM: arm/arm64: Enable KVM_CAP_NR_MEMSLOTS on
 arm/arm64
In-Reply-To: <1486538141-30627-2-git-send-email-linucherian@gmail.com>
References: <1486538141-30627-1-git-send-email-linucherian@gmail.com>
 <1486538141-30627-2-git-send-email-linucherian@gmail.com>
Message-ID: <20170223101027.GA1409@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 12:45:40PM +0530, linucherian at gmail.com wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
> 
> Return KVM_USER_MEM_SLOTS for userspace capability query on
> NR_MEMSLOTS.

This feature seems to be undocumented (I cannot find it in
Documentation/virtual/kvm/api.txt).

Can we add documentation for it?

What does user space do currently without this capability?  Does it just
rely on some default?

Thanks,
-Christoffer

> 
> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
> ---
>  arch/arm/kvm/arm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 9d74464..b64b47f 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -221,6 +221,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_MAX_VCPUS:
>  		r = KVM_MAX_VCPUS;
>  		break;
> +	case KVM_CAP_NR_MEMSLOTS:
> +		r = KVM_USER_MEM_SLOTS;
> +		break;
>  	case KVM_CAP_MSI_DEVID:
>  		if (!kvm)
>  			r = -EINVAL;
> -- 
> 1.9.1
> 
