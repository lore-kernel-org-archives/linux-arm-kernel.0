From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 13 Sep 2013 13:46:59 +0100
Subject: [PATCH] arm64: KVM: Increase max VCPUs per-Guest to 8
In-Reply-To: <1378904552-29347-1-git-send-email-anup.patel@linaro.org>
References: <1378904552-29347-1-git-send-email-anup.patel@linaro.org>
Message-ID: <52330943.4090309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/13 14:02, Anup Patel wrote:
> Current max VCPUs per-Guest is set to 4 which is preventing
> us from creating a Guest (or VM) with 8 VCPUs on Host (e.g.
> X-Gene Storm SOC) with 8 Host CPUs.
> 
> The correct value of max VCPUs per-Guest should be same as
> the max CPUs supported by GICv2 which is 8 hence this patch
> increases KVM_MAX_VCPUS to 8.

If anything, please make it configurable just like we have on 32bit. No
reason to impose the extra overhead on everyone.

Thanks,

	M.

> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  arch/arm64/include/asm/kvm_host.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 0859a4d..60ef29e 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -26,7 +26,7 @@
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_mmio.h>
>  
> -#define KVM_MAX_VCPUS 4
> +#define KVM_MAX_VCPUS 8
>  #define KVM_USER_MEM_SLOTS 32
>  #define KVM_PRIVATE_MEM_SLOTS 4
>  #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
> 


-- 
Jazz is not dead. It just smells funny...
