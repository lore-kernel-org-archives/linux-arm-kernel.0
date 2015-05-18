From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 May 2015 18:38:13 +0100
Subject: [PATCHv2 08/12] arm64: psci: remove ACPI coupling
In-Reply-To: <1431945503-6939-9-git-send-email-mark.rutland@arm.com>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
 <1431945503-6939-9-git-send-email-mark.rutland@arm.com>
Message-ID: <20150518173813.GO21251@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 11:38:19AM +0100, Mark Rutland wrote:
> The 32-bit ARM port doesn't have ACPI headers, and conditionally
> including them is going to look horrendous. In preparation for sharing
> the PSCI invocation code with 32-bit, move the acpi_psci_* function
> declarations and definitions such that the PSCI client code need not
> include ACPI headers.
> 
> While it would seem like we could simply hide the ACPI includes in
> psci.h, the ACPI headers have hilarious circular dependencies which make
> this infeasible without reorganising most of ACPICA. So rather than
> doing that, move the acpi_psci_* prototypes into psci.h.
> 
> The psci_acpi_init function is made dependent on CONFIG_ACPI (with a
> stub implementation in asm/psci.h) such that it need not be built for
> 32-bit ARM or kernels without ACPI support. The currently missing __init
> annotations are added to the prototypes in the header.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Cc: Al Stone <al.stone@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
