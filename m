From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 18 Mar 2013 13:03:50 -0400
Subject: [PATCH 22/29] arm64: KVM: define 32bit specific registers
In-Reply-To: <1362455265-24165-23-git-send-email-marc.zyngier@arm.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-23-git-send-email-marc.zyngier@arm.com>
Message-ID: <514748F6.7090903@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 03/04/2013 10:47 PM, Marc Zyngier wrote:
> Define the 32bit specific registers (SPSRs, cp15...).
> 
> Most CPU registers are directly mapped to a 64bit register
> (r0->x0...). Only the SPSRs have separate registers.
> 
> cp15 registers are also mapped into their 64bit counterpart in most
> cases.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h  | 38 +++++++++++++++++++++++++++++++++++++-

[...]

> +/* 32bit mapping */
> +#define c0_MPIDR	(MPIDR_EL1 * 2)	/* MultiProcessor ID Register */
> +#define c0_CSSELR	(CSSELR_EL1 * 2)/* Cache Size Selection Register */
> +#define c1_SCTLR	(SCTLR_EL1 * 2)	/* System Control Register */
> +#define c1_ACTLR	(ACTLR_EL1 * 2)	/* Auxilliary Control Register */

Auxiliary

> +#define c1_CPACR	(CPACR_EL1 * 2)	/* Coprocessor Access Control */
> +#define c2_TTBR0	(TTBR0_EL1 * 2)	/* Translation Table Base Register 0 */
> +#define c2_TTBR0_high	(c2_TTBR0 + 1)	/* TTBR0 top 32 bits */
> +#define c2_TTBR1	(TTBR1_EL1 * 2)	/* Translation Table Base Register 1 */
> +#define c2_TTBR1_high	(c2_TTBR1 + 1)	/* TTBR1 top 32 bits */
> +#define c2_TTBCR	(TCR_EL1 * 2)	/* Translation Table Base Control R. */
> +#define c3_DACR		(DACR32_EL2 * 2)/* Domain Access Control Register */
> +#define c5_DFSR		(ESR_EL1 * 2)	/* Data Fault Status Register */
> +#define c5_IFSR		(IFSR32_EL2 * 2)/* Instruction Fault Status Register */
> +#define c5_ADFSR	(AFSR0_EL1 * 2)	/* Auxilary Data Fault Status R */
> +#define c5_AIFSR	(AFSR1_EL1 * 2)	/* Auxilary Instr Fault Status R */

Auxiliary

> +#define c6_DFAR		(FAR_EL1 * 2)	/* Data Fault Address Register */
> +#define c6_IFAR		(c6_DFAR + 1)	/* Instruction Fault Address Register */
> +#define c10_PRRR	(MAIR_EL1 * 2)	/* Primary Region Remap Register */
> +#define c10_NMRR	(c10_PRRR + 1)	/* Normal Memory Remap Register */
> +#define c12_VBAR	(VBAR_EL1 * 2)	/* Vector Base Address Register */
> +#define c13_CID		(CONTEXTIDR_EL1 * 2)	/* Context ID Register */
> +#define c13_TID_URW	(TPIDR_EL0 * 2)	/* Thread ID, User R/W */
> +#define c13_TID_URO	(TPIDRRO_EL0 * 2)/* Thread ID, User R/O */
> +#define c13_TID_PRIV	(TPIDR_EL1 * 2)	/* Thread ID, Priveleged */

Privileged

> +#define c10_AMAIR	(AMAIR_EL1 * 2)	/* Aux Memory Attr Indirection Reg */
> +#define c14_CNTKCTL	(CNTKCTL_EL1 * 2) /* Timer Control Register (PL1) */
> +#define NR_CP15_REGS	(NR_SYS_REGS * 2)

[...]

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by
the Linux Foundation
