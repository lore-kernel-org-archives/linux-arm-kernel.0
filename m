From: drjones@redhat.com (Andrew Jones)
Date: Thu, 15 Mar 2018 16:05:03 +0100
Subject: [PATCH v6 24/26] arm64: Make BP hardening slot counter available
In-Reply-To: <20180314165049.30105-25-marc.zyngier@arm.com>
References: <20180314165049.30105-1-marc.zyngier@arm.com>
 <20180314165049.30105-25-marc.zyngier@arm.com>
Message-ID: <20180315150503.2jliarn6vjnqkmj4@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2018 at 04:50:47PM +0000, Marc Zyngier wrote:
> We're about to need to allocate hardening slots from other parts
> of the kernel (in order to support ARM64_HARDEN_EL2_VECTORS).
> 
> Turn the counter into an atomic_t and make it available to the
> rest of the kernel. Also add BP_HARDEN_EL2_SLOTS as the number of
> slots instead of the hardcoded 4...
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/mmu.h   | 3 +++
>  arch/arm64/kernel/bpi.S        | 3 ++-
>  arch/arm64/kernel/cpu_errata.c | 9 ++++-----
>  3 files changed, 9 insertions(+), 6 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
