From: drjones@redhat.com (Andrew Jones)
Date: Wed, 21 Feb 2018 18:34:43 +0100
Subject: [PATCH v4 08/40] KVM: arm/arm64: Introduce vcpu_el1_is_32bit
In-Reply-To: <20180215210332.8648-9-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-9-christoffer.dall@linaro.org>
Message-ID: <20180221173443.rr2vgn4xqnmeikqz@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 10:03:00PM +0100, Christoffer Dall wrote:
> We have numerous checks around that checks if the HCR_EL2 has the RW bit
> set to figure out if we're running an AArch64 or AArch32 VM.  In some
> cases, directly checking the RW bit (given its unintuitive name), is a
> bit confusing, and that's not going to improve as we move logic around
> for the following patches that optimize KVM on AArch64 hosts with VHE.
> 
> Therefore, introduce a helper, vcpu_el1_is_32bit, and replace existing
> direct checks of HCR_EL2.RW with the helper.
> 
> Reviewed-by: Julien Grall <julien.grall@arm.com>
> Reviewed-by: Julien Thierry <julien.thierry@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
> 
> Notes:
>     Changes since v2:
>      - New patch
>     
>     Changes since v1:
>      - Reworded comments as suggested by Drew
> 
>  arch/arm64/include/asm/kvm_emulate.h |  7 ++++++-
>  arch/arm64/kvm/hyp/switch.c          | 11 +++++------
>  arch/arm64/kvm/hyp/sysreg-sr.c       |  5 +++--
>  arch/arm64/kvm/inject_fault.c        |  6 +++---
>  4 files changed, 17 insertions(+), 12 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
