From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Sep 2018 15:17:46 +0100
Subject: [PATCH] arm64: sysreg: Clean up instructions for modifying
 PSTATE fields
In-Reply-To: <20180916221723.4306-1-suzuki.poulose@arm.com>
References: <20180916221723.4306-1-suzuki.poulose@arm.com>
Message-ID: <20180917141745.gwxahsxdmpee42zu@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 16, 2018 at 11:17:23PM +0100, Suzuki K. Poulose wrote:
> Instructions for modifying the PSTATE fields which were not supported
> in the older toolchains (e.g, PAN, UAO) are generated using macros.
> We have so far used the normal sys_reg() helper for defining the PSTATE
> fields. While this works fine, it is really difficult to correlate the
> code with the Arm ARM definition.
> 
> As per Arm ARM, the PSTATE fields are defined only using Op1, Op2 fields,
> with fixed values for Op0, CRn. Also the CRm field has been reserved
> for the Immediate value for the instruction. So using the sys_reg()
> looks quite confusing.
> 
> This patch cleans up the instruction helpers by bringing them
> in line with the Arm ARM definitions to make it easier to correlate
> code with the document. No functional changes.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v1
>  - Rebased to arm64 for-next/core.
>  - Cleanup SSBS defintions and replace CRm_shift => PSTATE_Imm_shift

Applied for 4.20. Thanks.

-- 
Catalin
