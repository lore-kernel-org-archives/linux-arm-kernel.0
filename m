From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Wed, 22 Oct 2014 21:24:44 -0500
Subject: [GIT PULL] SOCFPGA fixes for 3.18
Message-ID: <1414031084-14169-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider pulling these fixes for the SOCFPGA platform for v3.18.

Thanks,
Dinh

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga_fixes_for_3.18

for you to fetch changes up to efb4a44e24df2b98464977aee5be41148936fc7c:

  ARM: dts: socfpga: Add a 3.3V fixed regulator node (2014-10-22 21:00:19 -0500)

----------------------------------------------------------------
SOCFPGA fixes for 3.18

These patches fixes an SMP and SDMMC driver hang during boot up on the
SOCFPGA platform.

Patch "arm: socfpga: fix fetching cpu1start_addr for SMP" fixes the SMP
trampoline code in order for CPU1 to correctly fetch it's cpu1start_addr.

Patch "ARM: dts: socfpga: rename gpio nodes" renames that GPIO node in order
to allow a standard way of specifying status="okay" in the board DTS file.

Patch "ARM: dts: socfpga: Fix SD card detect" fixes a SDMMC driver hang
during boot. The reason for the hang was the deferred probe of the SDMMC
driver was waiting for the GPIO resource that would never come.

Patch "ARM: dts: socfpga: Add a 3.3V fixed regulator node" adds a fixed
regulator node for the SDMMC driver to use.

----------------------------------------------------------------
Dinh Nguyen (4):
      arm: socfpga: fix fetching cpu1start_addr for SMP
      ARM: dts: socfpga: rename gpio nodes
      ARM: dts: socfpga: Fix SD card detect
      ARM: dts: socfpga: Add a 3.3V fixed regulator node

 arch/arm/boot/dts/socfpga.dtsi                | 12 ++++++------
 arch/arm/boot/dts/socfpga_arria5.dtsi         |  2 +-
 arch/arm/boot/dts/socfpga_arria5_socdk.dts    | 12 ++++++++++++
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts  | 15 ++++++++++++++-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts | 12 ++++++++++++
 arch/arm/mach-socfpga/core.h                  |  2 +-
 arch/arm/mach-socfpga/headsmp.S               | 25 +++++++++++++++----------
 arch/arm/mach-socfpga/platsmp.c               |  4 ++--
 arch/arm/mach-socfpga/socfpga.c               |  4 ++--
 9 files changed, 65 insertions(+), 23 deletions(-)
