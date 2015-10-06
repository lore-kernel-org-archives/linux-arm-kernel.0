From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Tue, 6 Oct 2015 05:02:24 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.4
Message-ID: <1444125744-21798-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof,

Please consider pulling these patches for v4.4. For the arm64 patch, I don't
have an official ACK from the DTS guys, but I did get an "its looks okay"
with a condition that I fix up the ranges property for /soc node.

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/372136.html

Thanks,

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_for_v4.4

for you to fetch changes up to 78cd6a9d8e154fe2ac5d2b912519e27545cfd13b:

  arm64: dts: Add base stratix 10 dtsi (2015-10-06 04:42:38 -0500)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.4
- Add base arm64 dts for Statrix 10
- Peripheral updates for Arria10(USB,I2C,UART)

----------------------------------------------------------------
Dinh Nguyen (3):
      ARM: socfpga: dts: add clock fields for I2C, UART and USB on Arria10
      ARM: socfpga: dts: enable USB and I2C on Arria10 SoCDK
      arm64: dts: Add base stratix 10 dtsi

 arch/arm/boot/dts/socfpga_arria10.dtsi             |   8 +
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi       |  27 ++
 arch/arm64/Kconfig.platforms                       |   5 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/altera/Makefile                |   5 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 358 +++++++++++++++++++++
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |  39 +++
 arch/arm64/configs/defconfig                       |   1 +
 8 files changed, 444 insertions(+)
 create mode 100644 arch/arm64/boot/dts/altera/Makefile
 create mode 100644 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
 create mode 100644 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
