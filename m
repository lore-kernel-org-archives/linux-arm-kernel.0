From: alex.shi@linaro.org (Alex Shi)
Date: Fri,  9 Mar 2018 17:06:43 +0800
Subject: spectre backport for LTS 4.4 review
Message-ID: <20180309090722.26279-1-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This backport patchset fixed the spectre issue, it's original branch:
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
A few dependency or fixingpatches are also picked up, if they are necessary
 and no functional changes, specially as SMCCC support.

I tested it on hikey qemu w or w/o kvm, also no bug found from kernelci.org
and ltp and kself testing.

It also could be gotten from:
git://git.linaro.org/kernel/linux-linaro-stable.git v4.4-spectre

Any comments are appreciated!

Regards
Alex


[PATCH 01/39] mm: Introduce lm_alias
[PATCH 02/39] arm64: barrier: Add CSDB macros to control data-value
[PATCH 03/39] arm64: Implement array_index_mask_nospec()
[PATCH 04/39] arm64: move TASK_* definitions to <asm/processor.h>
[PATCH 05/39] arm64: Make USER_DS an inclusive limit
[PATCH 06/39] arm64: entry: Ensure branch through syscall table is
[PATCH 07/39] arm64: Use pointer masking to limit uaccess speculation
[PATCH 08/39] arm64: uaccess: Prevent speculative use of the current
[PATCH 09/39] arm64: uaccess: Don't bother eliding access_ok checks
[PATCH 10/39] arm64: futex: Mask __user pointers prior to dereference
[PATCH 11/39] drivers/firmware: Expose psci_get_version through
[PATCH 12/39] arm64: Move post_ttbr_update_workaround to C code
[PATCH 13/39] arm64: Add skeleton to harden the branch predictor
[PATCH 14/39] arm64: Move BP hardening to check_and_switch_context
[PATCH 15/39] arm64: KVM: Use per-CPU vector when BP hardening is
[PATCH 16/39] arm64: entry: Apply BP hardening for high-priority
[PATCH 17/39] arm64: entry: Apply BP hardening for suspicious
[PATCH 18/39] arm64: cpu_errata: Allow an erratum to be match for all
[PATCH 19/39] arm64: prefetch: add alternative pattern for CPUs
[PATCH 20/39] arm64: cputype: Add missing MIDR values for Cortex-A72
[PATCH 21/39] arm64: Implement branch predictor hardening for
[PATCH 22/39] arm64: KVM: Increment PC after handling an SMC trap
[PATCH 23/39] arm/arm64: KVM: Consolidate the PSCI include files
[PATCH 24/39] arm/arm64: KVM: Add PSCI_VERSION helper
[PATCH 25/39] arm/arm64: KVM: Add smccc accessors to PSCI code
[PATCH 26/39] arm/arm64: KVM: Implement PSCI 1.0 support
[PATCH 27/39] ARM: 8478/2: arm/arm64: add arm-smccc
[PATCH 28/39] ARM: 8479/2: add implementation for arm-smccc
[PATCH 29/39] ARM: 8480/2: arm64: add implementation for arm-smccc
[PATCH 30/39] ARM: 8481/2: drivers: psci: replace psci firmware calls
[PATCH 31/39] arm/arm64: KVM: Advertise SMCCC v1.1
[PATCH 32/39] arm/arm64: KVM: Turn kvm_psci_version into a static
[PATCH 33/39] arm64: KVM: Report SMCCC_ARCH_WORKAROUND_1 BP hardening
[PATCH 34/39] arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
[PATCH 35/39] firmware/psci: Expose PSCI conduit
[PATCH 36/39] firmware/psci: Expose SMCCC version through psci_ops
[PATCH 37/39] arm/arm64: smccc: Make function identifiers an unsigned
[PATCH 38/39] arm/arm64: smccc: Implement SMCCC v1.1 inline primitive
[PATCH 39/39] arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening
