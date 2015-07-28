From: dinh.linux@gmail.com (dinh.linux at gmail.com)
Date: Tue, 28 Jul 2015 10:12:44 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.3
Message-ID: <1438096364-28519-1-git-send-email-dinh.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please consider pulling these patches for v4.3.

Thanks,
Dinh

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_dts_for_v4.3

for you to fetch changes up to 2e4c7588f6c1d24ae991a85140e05139e953c9b5:

  ARM: socfpga: dts: add osc1 as a possible parent for dbg_base_clk (2015-07-24 22:10:59 -0500)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.3
- Update clocking for DTS nodes
- Add DTS board file for Terasic DE0 Atlas board
- Use stdout-patch for chosen node
- Enable prefetch-data and prefetch-instr

----------------------------------------------------------------
Dalon Westergreen (1):
      ARM: dts: socfpga: Add support of Terasic DE0 Atlas board

Dinh Nguyen (5):
      ARM: dts: socfpga: enable the data and instruction prefetch for the l2 cache
      ARM: dts: socfpga: use stdout-path for chosen node
      ARM: socfpga: dts: Correct the parent clock for l3_sp_clk and dbg_clk
      ARM: socfpga: dts: Fix gpio dts entry for the correct clock
      ARM: socfpga: dts: add osc1 as a possible parent for dbg_base_clk

Matthew Gerlach (1):
      ARM: socfpga: dts: add missing clock gates to socfpga.dtsi

 arch/arm/boot/dts/Makefile                        |   1 +
 arch/arm/boot/dts/socfpga.dtsi                    |  45 +++++++--
 arch/arm/boot/dts/socfpga_arria10.dtsi            |   5 +
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi      |   3 +-
 arch/arm/boot/dts/socfpga_arria5_socdk.dts        |   3 +-
 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts | 111 ++++++++++++++++++++++
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts      |   3 +-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts     |   3 +-
 8 files changed, 163 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
