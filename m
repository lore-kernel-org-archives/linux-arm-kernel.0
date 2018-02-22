From: drjones@redhat.com (Andrew Jones)
Date: Thu, 22 Feb 2018 14:51:41 +0100
Subject: [PATCH v4 27/40] KVM: arm64: Prepare to handle deferred
 save/restore of ELR_EL1
In-Reply-To: <20180215210332.8648-28-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-28-christoffer.dall@linaro.org>
Message-ID: <20180222135141.gdgfhaobe6z6mjum@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 10:03:19PM +0100, Christoffer Dall wrote:
> ELR_EL1 is not used by a VHE host kernel and can be deferred, but we
> need to rework the accesses to this register to access the latest value
> depending on whether or not guest system registers are loaded on the CPU
> or only reside in memory.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
> 
> Notes:
>     Changes since v2:
>      - New patch (deferred register handling has been reworked)
> 
>  arch/arm64/include/asm/kvm_emulate.h | 18 +++++++++++++++++-
>  arch/arm64/kvm/inject_fault.c        |  4 ++--
>  2 files changed, 19 insertions(+), 3 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
