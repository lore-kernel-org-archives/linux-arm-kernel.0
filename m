From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Wed, 13 May 2015 09:12:49 -0500
Subject: [GIT PULL] SoCFPGA updates for v4.2, version 2
In-Reply-To: <1431526369-1388-1-git-send-email-dinguyen@opensource.altera.com>
References: <1431526369-1388-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1431526369-1388-2-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider pulling in these patches for v4.2. This is version 2 that
includes the patch to use of_iomap of the A9 SCU.

Thanks,
Dinh

The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_updates_for_v4.2

for you to fetch changes up to 122694a0c71281cf2b349af41309c3caf5f31d61:

  ARM: socfpga: use of_iomap to map the SCU (2015-05-13 08:41:35 -0500)

----------------------------------------------------------------
SoCFPGA updates for v4.2
- Add big endian support
- Add earlyprintk support on UART1 that is used on Arria10
- Remove the need to map uart_io_desc
- Use of_iomap to map the SCU
- Remove socfpga_smp_init_cpus as arm_dt_init_cpu_maps is already doing
  the CPU mapping.

----------------------------------------------------------------
Ben Dooks (3):
      ARM: debug: fix big endian operation for 8250 word mode
      ARM: socfpga: enable big endian for secondary core(s)
      ARM: socfpga: support big endian for socfpga

Dinh Nguyen (3):
      ARM: socfpga: Add support for UART1 debug uart for earlyprintk
      ARM: socfpga: remove the need to map uart_io_desc
      ARM: socfpga: use of_iomap to map the SCU

 arch/arm/Kconfig.debug          | 26 +++++++++++++++++++-------
 arch/arm/include/debug/8250.S   |  3 +++
 arch/arm/mach-socfpga/Kconfig   |  1 +
 arch/arm/mach-socfpga/core.h    |  1 -
 arch/arm/mach-socfpga/headsmp.S |  5 ++++-
 arch/arm/mach-socfpga/platsmp.c | 33 ++++++++++-----------------------
 arch/arm/mach-socfpga/socfpga.c | 34 ----------------------------------
 7 files changed, 37 insertions(+), 66 deletions(-)
