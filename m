From: borntraeger@de.ibm.com (Christian Borntraeger)
Date: Fri, 15 May 2015 17:58:38 +0200
Subject: [PATCH v4 02/12] KVM: define common KVM_GUESTDBG_USE_SW/HW_BP bits
In-Reply-To: <1431700035-23479-3-git-send-email-alex.bennee@linaro.org>
References: <1431700035-23479-1-git-send-email-alex.bennee@linaro.org>
 <1431700035-23479-3-git-send-email-alex.bennee@linaro.org>
Message-ID: <555617AE.9030508@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 15.05.2015 um 16:27 schrieb Alex Benn?e:
> index ef1a5fc..aca4f86 100644
> --- a/arch/s390/include/uapi/asm/kvm.h
> +++ b/arch/s390/include/uapi/asm/kvm.h
> @@ -114,8 +114,6 @@ struct kvm_fpu {
>  	__u64 fprs[16];
>  };
> 
> -#define KVM_GUESTDBG_USE_HW_BP		0x00010000
> -


> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 70ac641..7c5dd11 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
[...]
> +#define KVM_GUESTDBG_USE_SW_BP		(1 << 16)
> +#define KVM_GUESTDBG_USE_HW_BP		(1 << 17)

This is a abi break for s390, no?

David do you remember why we did not use SW_BP?
