From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Jan 2017 17:08:27 +0000
Subject: [PATCH v3 1/9] arm64: cpufeature: treat unknown fields as RES0
In-Reply-To: <1483552147-9605-2-git-send-email-suzuki.poulose@arm.com>
References: <1483552147-9605-1-git-send-email-suzuki.poulose@arm.com>
 <1483552147-9605-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170105170826.GC29765@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 05:48:59PM +0000, Suzuki K. Poulose wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> Any fields not defined in an arm64_ftr_bits entry are propagated to the
> system-wide register value in init_cpu_ftr_reg(), and while we require
> that these strictly match for the sanity checks, we don't update them in
> update_cpu_ftr_reg().
> 
> Generally, the lack of an arm64_ftr_bits entry indicates that the bits
> are currently RES0 (as is the case for the upper 32 bits of all
> supposedly 32-bit registers).
> 
> A better default would be to use zero for the system-wide value of
> unallocated bits, making all register checking consistent, and allowing
> for subsequent simplifications to the arm64_ftr_bits arrays.
> 
> This patch updates init_cpu_ftr_reg() to treat unallocated bits as RES0
> for the purpose of the system-wide safe value. These bits will still be
> sanity checked with strict match requirements, as is currently the case.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
