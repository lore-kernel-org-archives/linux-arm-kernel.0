From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Fri, 06 Jul 2018 10:21:25 +0100
Subject: [RFC PATCH 04/16] KVM: arm64: Add missing #include of
 <linux/bitmap.h> to kvm_host.h
In-Reply-To: <1529593060-542-5-git-send-email-Dave.Martin@arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-5-git-send-email-Dave.Martin@arm.com>
Message-ID: <87a7r490tm.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> kvm_host.h uses DECLARE_BITMAP() to declare the features member of
> struct vcpu_arch, but the corresponding #include for this is
> missing.
>
> This patch adds a suitable #include for <linux/bitmap.h>.  Although
> the header builds without it today, this should help to avoid
> future surprises.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

> ---
>  arch/arm64/include/asm/kvm_host.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index fe8777b..92d6e88 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -22,6 +22,7 @@
>  #ifndef __ARM64_KVM_HOST_H__
>  #define __ARM64_KVM_HOST_H__
>
> +#include <linux/bitmap.h>
>  #include <linux/types.h>
>  #include <linux/kvm_types.h>
>  #include <asm/cpufeature.h>


--
Alex Benn?e
