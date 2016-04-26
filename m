From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue, 26 Apr 2016 10:24:04 -0500
Subject: [GIT PULL] SoCFPGA fixes for v4.6-rc5
Message-ID: <1461684244-6112-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof:

Please pull in these fixes for v4.6-rc5. The first patch "ARM: SoCFPGA: Fix
secondary CPU startup in thumb2 kernel" is a true fix for enabling CPU1 in
thumb2 mode, but the second patch "ARM: SoCFPGA: simplify secondary trampoline"
may not be a true fix, but it is dependent on the first patch. I didn't want
to cause any conflicts.

Thanks,

Dinh

The following changes since commit 02da2d72174c61988eb4456b53f405e3ebdebce4:

  Linux 4.6-rc5 (2016-04-24 16:17:05 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_fixes_for_v4.6

for you to fetch changes up to 162332eb719bc822c950732c343044bb3158f5fe:

  ARM: SoCFPGA: simplify secondary trampoline (2016-04-26 10:13:49 -0500)

----------------------------------------------------------------
SoCFPGA fixes against v4.6-rc5
- Fix secondary CPU startup in Thumb2 mode
- Simplify secondary CPU startup

----------------------------------------------------------------
Sascha Hauer (2):
      ARM: SoCFPGA: Fix secondary CPU startup in thumb2 kernel
      ARM: SoCFPGA: simplify secondary trampoline

 arch/arm/mach-socfpga/core.h    |  4 ++--
 arch/arm/mach-socfpga/headsmp.S | 28 ++++++++--------------
 arch/arm/mach-socfpga/platsmp.c | 51 +++++++++++++++++++----------------------
 arch/arm/mach-socfpga/socfpga.c |  9 --------
 4 files changed, 34 insertions(+), 58 deletions(-)
