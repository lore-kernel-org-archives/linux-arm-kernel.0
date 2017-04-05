From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed,  5 Apr 2017 10:01:28 -0500
Subject: [GIT PULL 1/2] SoCFPGA DTS updates for v4.12
Message-ID: <1491404489-10411-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in these DTS updates for v4.12.

Thanks,
Dinh

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_for_v4.12

for you to fetch changes up to 7fed0cbffe1db3383ae1900fffc8f4e14d2735c8:

  ARM: dts: socfpga: Add Devkit A10-SR Reset Controller (2017-03-16 07:57:16 -0500)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.12
- Clean-up:
	- Add clock/memory nodes
	- Add labels for CPU nodes
	- Remove unused unit names and reg
	- Remove unused skeleton.dtsi
- Add support for PMU
- Add QSPI for sodia board
- Add Reset controller for Arria10

----------------------------------------------------------------
Florian Vaussard (8):
      ARM: dts: socfpga: Add unit name to clock nodes
      ARM: dts: socfpga: Add unit name to memory nodes
      ARM: dts: socfpga: Remove unneeded unit names
      ARM: dts: socfpga: Remove unneeded reg from stmpe_touchscreen
      ARM: dts: socfpga: Remove unit name for LEDs in EBV SOCrates
      ARM: dts: socfpga: Do not include skeleton.dtsi
      ARM: dts: socfpga: Add labels for CPU nodes
      ARM: dts: socfpga: Add support for PMU

Nobuhiro Iwamatsu (1):
      ARM: dts: socfpga: sodia: enable qspi

Thor Thayer (1):
      ARM: dts: socfpga: Add Devkit A10-SR Reset Controller

 arch/arm/boot/dts/socfpga.dtsi                     | 56 ++++++++++++----------
 arch/arm/boot/dts/socfpga_arria10.dtsi             | 51 ++++++++++----------
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi       |  7 ++-
 arch/arm/boot/dts/socfpga_arria5_socdk.dts         |  2 +-
 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts  |  2 +-
 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi        |  2 +-
 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts      |  1 -
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       |  2 +-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      |  2 +-
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts    |  8 ++--
 arch/arm/boot/dts/socfpga_cyclone5_sodia.dts       | 23 ++++++++-
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts |  2 +-
 arch/arm/boot/dts/socfpga_vt.dts                   |  2 +-
 13 files changed, 96 insertions(+), 64 deletions(-)
