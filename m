From: drjones@redhat.com (Andrew Jones)
Date: Thu, 22 Feb 2018 14:49:04 +0100
Subject: [PATCH v4 26/40] KVM: arm/arm64: Prepare to handle deferred
 save/restore of SPSR_EL1
In-Reply-To: <20180215210332.8648-27-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-27-christoffer.dall@linaro.org>
Message-ID: <20180222134904.vwbdauxzdca53psq@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 10:03:18PM +0100, Christoffer Dall wrote:
> SPSR_EL1 is not used by a VHE host kernel and can be deferred, but we
> need to rework the accesses to this register to access the latest value
> depending on whether or not guest system registers are loaded on the CPU
> or only reside in memory.
> 
> The handling of accessing the various banked SPSRs for 32-bit VMs is a
> bit clunky, but this will be improved in following patches which will
> first prepare and subsequently implement deferred save/restore of the
> 32-bit registers, including the 32-bit SPSRs.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
> 
> Notes:
>     Changes since v2:
>      - New patch (deferred register handling has been reworked)
> 
>  arch/arm/include/asm/kvm_emulate.h   | 12 ++++++++++-
>  arch/arm/kvm/emulate.c               |  2 +-
>  arch/arm64/include/asm/kvm_emulate.h | 41 +++++++++++++++++++++++++++++++-----
>  arch/arm64/kvm/inject_fault.c        |  4 ++--
>  virt/kvm/arm/aarch32.c               |  2 +-
>  5 files changed, 51 insertions(+), 10 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
