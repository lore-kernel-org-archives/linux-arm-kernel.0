From: drjones@redhat.com (Andrew Jones)
Date: Wed, 21 Feb 2018 18:47:31 +0100
Subject: [PATCH v4 20/40] KVM: arm/arm64: Remove leftover comment from
 kvm_vcpu_run_vhe
In-Reply-To: <20180215210332.8648-21-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-21-christoffer.dall@linaro.org>
Message-ID: <20180221174731.mrykgulbdjesyz4m@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 10:03:12PM +0100, Christoffer Dall wrote:
> The comment only applied to SPE on non-VHE systems, so we simply remove
> it.
> 
> Suggested-by: Andrew Jones <drjones@redhat.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm64/kvm/hyp/switch.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 717c8f5c6be7..a99224996e33 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -410,10 +410,6 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
>  		__fpsimd_restore_state(&host_ctxt->gp_regs.fp_regs);
>  	}
>  
> -	/*
> -	 * This must come after restoring the host sysregs, since a non-VHE
> -	 * system may enable SPE here and make use of the TTBRs.
> -	 */
>  	__debug_switch_to_host(vcpu);
>  
>  	return exit_code;
> -- 
> 2.14.2
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
