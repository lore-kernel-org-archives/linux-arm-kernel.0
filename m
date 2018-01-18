From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 18 Jan 2018 21:28:31 +0100
Subject: [PATCH v4 19/19] arm64: Update the KVM memory map documentation
In-Reply-To: <20180104184334.16571-20-marc.zyngier@arm.com>
References: <20180104184334.16571-1-marc.zyngier@arm.com>
 <20180104184334.16571-20-marc.zyngier@arm.com>
Message-ID: <20180118202831.GG21802@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 04, 2018 at 06:43:34PM +0000, Marc Zyngier wrote:
> Update the documentation to reflect the new tricks we play on the
> EL2 mappings...
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

> ---
>  Documentation/arm64/memory.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/arm64/memory.txt b/Documentation/arm64/memory.txt
> index 671bc0639262..ea64e20037f6 100644
> --- a/Documentation/arm64/memory.txt
> +++ b/Documentation/arm64/memory.txt
> @@ -86,9 +86,11 @@ Translation table lookup with 64KB pages:
>   +-------------------------------------------------> [63] TTBR0/1
>  
>  
> -When using KVM without the Virtualization Host Extensions, the hypervisor
> -maps kernel pages in EL2 at a fixed offset from the kernel VA. See the
> -kern_hyp_va macro for more details.
> +When using KVM without the Virtualization Host Extensions, the
> +hypervisor maps kernel pages in EL2 at a fixed offset (modulo a random
> +offset) from the linear mapping. See the kern_hyp_va macro and
> +kvm_update_va_mask function for more details. MMIO devices such as
> +GICv2 gets mapped next to the HYP idmap page.
>  
>  When using KVM with the Virtualization Host Extensions, no additional
>  mappings are created, since the host kernel runs directly in EL2.
> -- 
> 2.14.2
> 
