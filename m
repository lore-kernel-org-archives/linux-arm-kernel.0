From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jul 2018 14:12:33 +0100
Subject: [PATCH 6/7] kvm/arm: use PSR_AA32 definitions
In-Reply-To: <20180625144421.11511-7-mark.rutland@arm.com>
References: <20180625144421.11511-1-mark.rutland@arm.com>
 <20180625144421.11511-7-mark.rutland@arm.com>
Message-ID: <20180704131232.GB2798@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 03:44:20PM +0100, Mark Rutland wrote:
> Some code cares about the SPSR_ELx format for exceptions taken from
> AArch32 to inspect or manipulate the SPSR_ELx value, which is already in
> the SPSR_ELx format, and not in the AArch32 PSR format.
> 
> To separate these from cases where we care about the AArch32 PSR format,
> migrate these cases to use the PSR_AA32_* definitions rather than
> COMPAT_PSR_*.
> 
> There should be no functional change as a result of this patch.
> 
> Note that arm64 KVM does not support a compat KVM API, and always uses
> the SPSR_ELx format, even for AArch32 guests.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/kvm_emulate.h       | 14 +++++++-------
>  arch/arm64/include/asm/kvm_emulate.h     | 10 +++++-----
>  arch/arm64/kvm/guest.c                   | 14 +++++++-------
>  arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c |  2 +-
>  arch/arm64/kvm/regmap.c                  | 22 +++++++++++-----------
>  arch/arm64/kvm/reset.c                   |  4 ++--
>  virt/kvm/arm/aarch32.c                   | 20 ++++++++++----------
>  7 files changed, 43 insertions(+), 43 deletions(-)

I need an ack from the KVM maintainers before I can take this. I can also
put this series on a separate branch if necessary.

Will
