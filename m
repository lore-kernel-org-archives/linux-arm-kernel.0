From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 13 Dec 2013 17:36:12 +0000
Subject: [PATCH] arm64: KVM: Force undefined exception for Guest SMC
 intructions
In-Reply-To: <1386864747-29006-2-git-send-email-anup.patel@linaro.org>
References: <1386864747-29006-1-git-send-email-anup.patel@linaro.org>
 <1386864747-29006-2-git-send-email-anup.patel@linaro.org>
Message-ID: <52AB458C.4020507@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/13 16:12, Anup Patel wrote:
> The SMC-based PSCI emulation for Guest is going to be very different
> from the in-kernel HVC-based PSCI emulation hence for now just inject
> undefined exception when Guest executes SMC instruction.
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

> ---
>  arch/arm64/kvm/handle_exit.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 8da5606..df84d7b 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -39,9 +39,6 @@ static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  
>  static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
> -	if (kvm_psci_call(vcpu))
> -		return 1;
> -
>  	kvm_inject_undefined(vcpu);
>  	return 1;
>  }
> 


-- 
Jazz is not dead. It just smells funny...
