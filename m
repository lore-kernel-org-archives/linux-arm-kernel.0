From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Apr 2016 16:15:41 +0100
Subject: [PATCH v2 01/17] arm64: Reuse TCR field definitions for EL1 and
 EL2
In-Reply-To: <1460640065-27658-2-git-send-email-suzuki.poulose@arm.com>
References: <1460640065-27658-1-git-send-email-suzuki.poulose@arm.com>
 <1460640065-27658-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160415151541.GO22906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 02:20:49PM +0100, Suzuki K Poulose wrote:
> TCR_EL1, TCR_EL2 and VTCR_EL2, all share some field positions
> (TG0, ORGN0, IRGN0 and SH0) and their corresponding value definitions.
> 
> This patch makes the TCR_EL1 definitions reusable and uses them for TCR_EL2
> and VTCR_EL2 fields.
> 
> This also fixes a bug where we assume TG0 in {V}TCR_EL2 is 1bit field.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/kvm_arm.h       |   48 ++++++++++---------
>  arch/arm64/include/asm/pgtable-hwdef.h |   80 +++++++++++++++++++++++++-------
>  2 files changed, 88 insertions(+), 40 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Feel free to take this through the kvm-arm tree.

Will
