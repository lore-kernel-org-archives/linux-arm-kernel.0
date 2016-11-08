From: will.deacon@arm.com (Will Deacon)
Date: Tue, 8 Nov 2016 18:11:03 +0000
Subject: [PATCH v3 1/2] arm64: Add hypervisor safe helper for checking
 constant capabilities
In-Reply-To: <1478613381-5718-2-git-send-email-suzuki.poulose@arm.com>
References: <1478613381-5718-1-git-send-email-suzuki.poulose@arm.com>
 <1478613381-5718-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20161108181103.GM20591@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 01:56:20PM +0000, Suzuki K Poulose wrote:
> The hypervisor may not have full access to the kernel data structures
> and hence cannot safely use cpus_have_cap() helper for checking the
> system capability. Add a safe helper for hypervisors to check a constant
> system capability, which *doesn't* fall back to checking the bitmap
> maintained by the kernel. With this, make the cpus_have_cap() only
> check the bitmask and force constant cap checks to use the new API
> for quicker checks.
> 
> Cc: Robert Ritcher <rritcher@cavium.com>
> Cc: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h | 19 ++++++++++++-------
>  arch/arm64/kernel/cpufeature.c      |  2 +-
>  arch/arm64/kernel/process.c         |  2 +-
>  drivers/irqchip/irq-gic-v3.c        | 13 +------------

It might be worth having the GIC changes as a separate patch, but either
way:

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
