From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 22 Dec 2017 15:44:29 +0000
Subject: [PATCH v2 3/8] arm64: handle 52-bit addresses in TTBR
In-Reply-To: <20171222152307.11252-4-catalin.marinas@arm.com>
References: <20171222152307.11252-1-catalin.marinas@arm.com>
 <20171222152307.11252-4-catalin.marinas@arm.com>
Message-ID: <d2dc3099-8be9-598a-8d13-c8ed1edfb806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/12/17 15:23, Catalin Marinas wrote:
> From: Kristina Martsenko <kristina.martsenko@arm.com>
> 
> The top 4 bits of a 52-bit physical address are positioned at bits 2..5
> in the TTBR registers. Introduce a couple of macros to move the bits
> there, and change all TTBR writers to use them.
> 
> Leave TTBR0 PAN code unchanged, to avoid complicating it. A system with
> 52-bit PA will have PAN anyway (because it's ARMv8.1 or later), and a
> system without 52-bit PA can only use up to 48-bit PAs. A later patch in
> this series will add a kconfig dependency to ensure PAN is configured.
> 
> In addition, when using 52-bit PA there is a special alignment
> requirement on the top-level table. We don't currently have any VA_BITS
> configuration that would violate the requirement, but one could be added
> in the future, so add a compile-time BUG_ON to check for it.
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> Tested-by: Bob Picco <bob.picco@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> [catalin.marinas at arm.com: added TTBR_BADD_MASK_52 comment]
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

And also, tested both the host and KVM bits, so:

Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
