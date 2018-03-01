From: alex.shi@linaro.org (Alex Shi)
Date: Thu,  1 Mar 2018 20:53:37 +0800
Subject: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
Message-ID: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Resent without non-upstream patches.

This backport patchset fixed the spectre issue, it's original branch:
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
A few dependency or fixingpatches are also picked up, if they are necessary
 and no functional changes.

No bug found from kernelci.org and lkft testing. It also could be gotten from:

git://git.linaro.org/kernel/linux-linaro-stable.git v4.9-spectre-upstream-only

Comments are appreciated!

Regards
Alex


[PATCH 01/45] mm: Introduce lm_alias
[PATCH 02/45] arm64: alternatives: apply boot time fixups via the
[PATCH 03/45] arm64: barrier: Add CSDB macros to control data-value
[PATCH 04/45] arm64: Implement array_index_mask_nospec()
[PATCH 05/45] arm64: move TASK_* definitions to <asm/processor.h>
[PATCH 06/45] arm64: Factor out PAN enabling/disabling into separate
[PATCH 07/45] arm64: Factor out TTBR0_EL1 post-update workaround into
[PATCH 08/45] arm64: uaccess: consistently check object sizes
[PATCH 09/45] arm64: Make USER_DS an inclusive limit
[PATCH 10/45] arm64: Use pointer masking to limit uaccess speculation
[PATCH 11/45] arm64: syscallno is secretly an int, make it official
[PATCH 12/45] arm64: entry: Ensure branch through syscall table is
[PATCH 13/45] arm64: uaccess: Prevent speculative use of the current
[PATCH 14/45] arm64: uaccess: Don't bother eliding access_ok checks
[PATCH 15/45] arm64: uaccess: Mask __user pointers for __arch_{clear,
[PATCH 16/45] arm64: futex: Mask __user pointers prior to dereference
[PATCH 17/45] drivers/firmware: Expose psci_get_version through
[PATCH 18/45] arm64: cpufeature: __this_cpu_has_cap() shouldn't stop
[PATCH 19/45] arm64: cpu_errata: Allow an erratum to be match for all
[PATCH 20/45] arm64: Run enable method for errata work arounds on
[PATCH 21/45] arm64: cpufeature: Pass capability structure to
[PATCH 22/45] arm64: Move post_ttbr_update_workaround to C code
[PATCH 23/45] arm64: Add skeleton to harden the branch predictor
[PATCH 24/45] arm64: Move BP hardening to check_and_switch_context
[PATCH 25/45] arm64: KVM: Use per-CPU vector when BP hardening is
[PATCH 26/45] arm64: entry: Apply BP hardening for high-priority
[PATCH 27/45] arm64: entry: Apply BP hardening for suspicious
[PATCH 28/45] arm64: cputype: Add missing MIDR values for Cortex-A72
[PATCH 29/45] arm64: Implement branch predictor hardening for
[PATCH 30/45] arm64: KVM: Increment PC after handling an SMC trap
[PATCH 31/45] arm/arm64: KVM: Consolidate the PSCI include files
[PATCH 32/45] arm/arm64: KVM: Add PSCI_VERSION helper
[PATCH 33/45] arm/arm64: KVM: Add smccc accessors to PSCI code
[PATCH 34/45] arm/arm64: KVM: Implement PSCI 1.0 support
[PATCH 35/45] arm/arm64: KVM: Advertise SMCCC v1.1
[PATCH 36/45] arm64: KVM: Make PSCI_VERSION a fast path
[PATCH 37/45] arm/arm64: KVM: Turn kvm_psci_version into a static
[PATCH 38/45] arm64: KVM: Report SMCCC_ARCH_WORKAROUND_1 BP hardening
[PATCH 39/45] arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
[PATCH 40/45] firmware/psci: Expose PSCI conduit
[PATCH 41/45] firmware/psci: Expose SMCCC version through psci_ops
[PATCH 42/45] arm/arm64: smccc: Make function identifiers an unsigned
[PATCH 43/45] arm/arm64: smccc: Implement SMCCC v1.1 inline primitive
[PATCH 44/45] arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening
[PATCH 45/45] arm64: Kill PSCI_GET_VERSION as a variant-2 workaround
