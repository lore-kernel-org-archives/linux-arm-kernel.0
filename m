From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Mon, 17 Nov 2014 22:03:34 -0600
Subject: [GIT PULL 1/2] SOCFPGA update for v3.19
Message-ID: <1416283415-6563-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider pulling in this one patch for v3.19. The SOCFPGA chip has
a quirk that causes it to consume more power when CPU1 is put in reset
instead of WFI when it is hot-unplugged. This patch fixes this issue.

Thanks,

The following changes since commit 206c5f60a3d902bc4b56dab2de3e88de5eb06108:

  Linux 3.18-rc4 (2014-11-09 14:55:29 -0800)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga_update_for_v3.19

for you to fetch changes up to e15a11e885423aff12ed841677108fde4de40319:

  socfpga: hotplug: put cpu1 in wfi (2014-11-17 15:23:42 -0600)

----------------------------------------------------------------
SoCFPGA update for v3.19

Use WFI instead of putting CPU1 into reset will fix problem of increased
power when unplugging CPU1.

----------------------------------------------------------------
Alan Tull (1):
      socfpga: hotplug: put cpu1 in wfi

 arch/arm/mach-socfpga/core.h    |  3 +++
 arch/arm/mach-socfpga/platsmp.c | 19 +++++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)
