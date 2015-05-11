From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Mon, 11 May 2015 14:12:09 -0500
Subject: [GIT PULL] SoCFPGA updates for v4.2
In-Reply-To: <1431371529-22593-1-git-send-email-dinguyen@opensource.altera.com>
References: <1431371529-22593-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1431371529-22593-2-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider pulling in these patches for v4.2.

Thanks,
Dinh

The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  git://git.kernel.org:pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_updates_for_v4.2

for you to fetch changes up to 65ce7a37ec23c9e7878bd77e2f75b1eb9d8926e3:

  ARM: socfpga: remove the need to map uart_io_desc (2015-05-11 13:59:53 -0500)

----------------------------------------------------------------
SoCFPGA updates for v4.2
- Add big endian support
- Add earlyprintk support on UART1 that is used on Arria10
- Remove the need to map uart_io_desc

----------------------------------------------------------------
Ben Dooks (3):
      ARM: debug: fix big endian operation for 8250 word mode
      ARM: socfpga: enable big endian for secondary core(s)
      ARM: socfpga: support big endian for socfpga

Dinh Nguyen (2):
      ARM: socfpga: Add support for UART1 debug uart for earlyprintk
      ARM: socfpga: remove the need to map uart_io_desc

 arch/arm/Kconfig.debug          | 26 +++++++++++++++++++-------
 arch/arm/include/debug/8250.S   |  3 +++
 arch/arm/mach-socfpga/Kconfig   |  1 +
 arch/arm/mach-socfpga/headsmp.S |  5 ++++-
 arch/arm/mach-socfpga/socfpga.c |  9 ---------
 5 files changed, 27 insertions(+), 17 deletions(-)
