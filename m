From: tn@semihalf.com (Tomasz Nowicki)
Date: Wed, 31 Jan 2018 13:24:16 +0100
Subject: [PATCH v3 33/41] KVM: arm64: Configure FPSIMD traps on vcpu
 load/put
In-Reply-To: <20180112120747.27999-34-christoffer.dall@linaro.org>
References: <20180112120747.27999-1-christoffer.dall@linaro.org>
 <20180112120747.27999-34-christoffer.dall@linaro.org>
Message-ID: <582cf940-51b3-1492-f23a-980b99331d00@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.01.2018 13:07, Christoffer Dall wrote:
> There is no need to enable/disable traps to FP registers on every switch
> to/from the VM, because the host kernel does not use this resource
> without calling vcpu_put.  We can therefore move things around enough
> that we still always write FPEXC32_EL2 before programming CPTR_EL2 but
> only program these during vcpu load/put.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>   arch/arm64/include/asm/kvm_hyp.h |  6 +++++
>   arch/arm64/kvm/hyp/switch.c      | 51 +++++++++++++++++++++++++++++-----------
>   arch/arm64/kvm/hyp/sysreg-sr.c   | 12 ++++++++--
>   3 files changed, 53 insertions(+), 16 deletions(-)
> 

[...]

>   
> -static void __hyp_text __deactivate_traps_nvhe(void)
> -{
> +static void __hyp_text __deactivate_traps_nvhe(void) {

Nit: unrelated change.

Thanks,
Tomasz
