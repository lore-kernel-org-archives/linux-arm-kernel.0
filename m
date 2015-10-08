From: robh@kernel.org (Rob Herring)
Date: Thu,  8 Oct 2015 12:53:34 -0500
Subject: [PATCH v2 00/13] Enable building all dtb files
Message-ID: <1444326827-3565-1-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables building all the dtb files in the kernel mostly 
independent of the kernel config. The option is only dependent on 
COMPILE_TEST, OF, and the new OF_ALL_DTBS options. This ensures that 
allyesconfig builds can build all dtb files although most arches have to 
build "dtbs" target explicitly. Some arches like ARM include dtbs in the 
default target.

Arch/arm-soc maintainers, Please ack and I will take this series via the DT 
tree.

v2:
- Add OF_ALL_DTBS option hidden behind COMPILE_TEST
- Expand to all architectures (with more than 1 dtb)

Rob


Rob Herring (13):
  of: add config option to enable building of all dtbs
  arc: use common make variables for dtb builds
  arc: enable building of all dtbs
  arm: enable building of all dtbs
  arm64: enable building of all dtbs
  h8300: enable building of all dtbs
  metag: use common make variables for dtb builds
  metag: enable building of all dtbs
  mips: enable building of all dtbs
  nios2: use common make variables for dtb builds
  nios2: enable building of all dtbs
  powerpc: enable building of all dtbs
  xtensa: enable building of all dtbs

 arch/arc/Makefile              |  2 +-
 arch/arc/boot/dts/Makefile     |  6 ++++--
 arch/arm/boot/dts/Makefile     |  3 +++
 arch/arm64/boot/dts/Makefile   |  6 ++++++
 arch/h8300/boot/dts/Makefile   |  3 +++
 arch/metag/Makefile            |  2 +-
 arch/metag/boot/dts/Makefile   |  7 +++----
 arch/mips/boot/dts/Makefile    |  3 +++
 arch/nios2/Makefile            | 10 +++++-----
 arch/nios2/boot/Makefile       | 13 +++----------
 arch/nios2/boot/dts/Makefile   |  6 ++++++
 arch/powerpc/Makefile          |  6 ++++++
 arch/powerpc/boot/Makefile     |  5 ++++-
 arch/powerpc/boot/dts/Makefile |  5 +++++
 arch/xtensa/Makefile           |  4 ++++
 arch/xtensa/boot/dts/Makefile  |  7 ++++++-
 drivers/of/Kconfig             | 10 ++++++++++
 17 files changed, 73 insertions(+), 25 deletions(-)
 create mode 100644 arch/nios2/boot/dts/Makefile
 create mode 100644 arch/powerpc/boot/dts/Makefile

-- 
2.1.4
