From: salyzyn@android.com (Mark Salyzyn)
Date: Mon,  1 Oct 2018 10:58:20 -0700
Subject: RESEND and REBASE arm+arm64+aarch32 vdso rewrite
Message-ID: <20181001175845.168430-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Last sent 23 Nov 2016.

The following 23 patches are rebased and resent, and represent a
rewrite of the arm and arm64 vDSO into C, adding support for arch32
(32-bit user space hosted 64-bit kernels) and into a common library
that other (arm, or non-arm) architectures may utilize.

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
[PATCH v6 11/12] lib: vdso: Add support for CLOCK_BOOTTIME
[PATCH v5 12/12] lib: vdso: do not expose gettimeofday, if no arch supported timer
[PATCH] lib: vdso: add support for time
[PATCH v2 1/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (C sources)
[PATCH v2 2/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (assembler sources)
[PATCH v2 3/3] arm64: compat: Add CONFIG_KUSER_HELPERS
[PATCH] arm64: compat: Expose offset to registers in sigframes
[PATCH 1/6] arm64: compat: Use vDSO sigreturn trampolines if available
[PATCH 2/6] arm64: elf: Set AT_SYSINFO_EHDR in compat processes
[PATCH 3/6] arm64: Refactor vDSO init/setup
[PATCH v2 4/6] arm64: compat: Add a 32-bit vDSO
[PATCH 5/6] arm64: compat: 32-bit vDSO setup
[PATCH 6/6] arm64: Wire up and expose the new compat vDSO

This patch series' above has been applied to the latest Pixel phones
and resulted in a 0.4% battery improvement.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Tested-by: Mark Salyzyn <salyzyn@android.com>
Cc: James Morse <james.morse@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Andrew Pinski <apinski@cavium.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
Cc: android-kernel at android.com
