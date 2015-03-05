From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Wed, 4 Mar 2015 23:25:36 -0600
Subject: [GIT PULL] SoCFPGA fixes for v4.0
Message-ID: <1425533136-31995-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider pulling in these patches for v4.0. The patch from Russell is
probably the most important as it's fixed a sporadic SMP issue where CPU1
start address variable was being cached away, and never made it to physical
memory.

Thanks,

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga_fixes_for_v4.0

for you to fetch changes up to cee9b8d6b8b7d82bfb34e4700d839aec76519f02:

  ARM: socfpga: make sure socfpga_cpu1start_addr is properly flushed (2015-03-04 13:03:17 -0600)

----------------------------------------------------------------
Fixes for v4.0 on the SoCFPGA platform:
- Fix the SCU virtual mapping
- Add misssing DMA channels for UART nodes
- Fix a sporadic SMP error where CPU1 was not seeing its start address

----------------------------------------------------------------
Russell King (1):
      ARM: socfpga: make sure socfpga_cpu1start_addr is properly flushed

Steffen Trumtrar (1):
      ARM: socfpga: fix uart DMA binding error

Vince Bridgers (1):
      ARM: socfpga: Correct SCU virtual mapping in socfpga

 arch/arm/boot/dts/socfpga.dtsi  | 6 ++++++
 arch/arm/mach-socfpga/core.h    | 2 +-
 arch/arm/mach-socfpga/socfpga.c | 5 +++++
 3 files changed, 12 insertions(+), 1 deletion(-)
