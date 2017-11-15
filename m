From: salyzyn@android.com (Mark Salyzyn)
Date: Wed, 15 Nov 2017 14:05:10 -0800
Subject: [PATCH 0/6] arm64: compat: Add COMPAT_VDSO
Message-ID: <20171115220529.14458-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible vDSO32 support to arm64, provide the files necessary
for building a compat (AArch32) vDSO in arch/arm64/kernel/vdso32.

Leverages effort to unify the vgettimeofday.c file as outlined below.

To be applied over top the following pending patches:

[PATCH] arm64: compat: Remove leftover variable declaration
NB: approved, in arch64/for-next/core
[PATCH v3 1/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (C sources)
[PATCH v3 2/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (assembler sources)
[PATCH v3 3/3] arm64: compat: Add CONFIG_KUSER_HELPERS
[PATCH] arm64: compat: Expose offset to registers in sigframes
[PATCH v5 01/12] arm: vdso: rename vdso_datapage variables
[PATCH v5 02/12] arm: vdso: add include file defining __get_datapage()
[PATCH v5 03/12] arm: vdso: inline assembler operations to compiler.h
[PATCH v5 04/12] arm: vdso: do calculations outside reader loops
[PATCH v6 05/12] arm: vdso: Add support for CLOCK_MONOTONIC_RAW
[PATCH v5 06/12] arm: vdso: add support for clock_getres
[PATCH v5 07/12] arm: vdso: disable profiling
[PATCH v5 08/12] arm: vdso: Add ARCH_CLOCK_FIXED_MASK
[PATCH v5 09/12] arm: vdso: move vgettimeofday.c to lib/vdso/
[PATCH v5 10/12] arm64: vdso: replace gettimeofday.S with global vgettimeofday.C
[PATCH v5 11/12] lib: vdso: Add support for CLOCK_BOOTTIME
[PATCH v5 12/12] lib: vdso: do not expose gettimeofday, if no arch supported timer
[PATCH] lib: vdso: add support for time

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
