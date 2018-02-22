From: drjones@redhat.com (Andrew Jones)
Date: Thu, 22 Feb 2018 16:51:02 +0100
Subject: [PATCH v4 33/40] KVM: arm64: Configure c15, PMU, and debug
 register traps on cpu load/put for VHE
In-Reply-To: <20180215210332.8648-34-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-34-christoffer.dall@linaro.org>
Message-ID: <20180222155102.6t4ptrtt7yvewn47@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 10:03:25PM +0100, Christoffer Dall wrote:
> We do not have to change the c15 trap setting on each switch to/from the
> guest on VHE systems, because this setting only affects EL0.
> 
> The PMU and debug trap configuration can also be done on vcpu load/put
> instead, because they don't affect how the host kernel can access the
> debug registers while executing KVM kernel code.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm64/include/asm/kvm_hyp.h |  3 +++
>  arch/arm64/kvm/hyp/switch.c      | 31 ++++++++++++++++++++++---------
>  arch/arm64/kvm/hyp/sysreg-sr.c   |  4 ++++
>  3 files changed, 29 insertions(+), 9 deletions(-)
>

The last patch 32/40 probably should have been closer to 13/40 in
this series. That would allow this patch to directly follow it's
preparatory patch 31/40, but I'm just whiny reviewer...

Reviewed-by: Andrew Jones <drjones@redhat.com>
