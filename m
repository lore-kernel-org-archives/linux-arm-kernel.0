From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Fri, 06 Jul 2018 10:08:37 +0100
Subject: [RFC PATCH 02/16] KVM: arm64: Delete orphaned declaration for
 __fpsimd_enabled()
In-Reply-To: <1529593060-542-3-git-send-email-Dave.Martin@arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <87efgg91ey.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> __fpsimd_enabled() no longer exists, but a dangling declaration has
> survived in kvm_hyp.h.
>
> This patch gets rid of it.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

> ---
>  arch/arm64/include/asm/kvm_hyp.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
> index 384c343..9cbbd03 100644
> --- a/arch/arm64/include/asm/kvm_hyp.h
> +++ b/arch/arm64/include/asm/kvm_hyp.h
> @@ -147,7 +147,6 @@ void __debug_switch_to_host(struct kvm_vcpu *vcpu);
>
>  void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
>  void __fpsimd_restore_state(struct user_fpsimd_state *fp_regs);
> -bool __fpsimd_enabled(void);
>
>  void activate_traps_vhe_load(struct kvm_vcpu *vcpu);
>  void deactivate_traps_vhe_put(void);


--
Alex Benn?e
