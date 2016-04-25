From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 25 Apr 2016 17:31:15 +0100
Subject: [GIT PULL v2 1/2] ARM: vexpress: addition of MPS2 platform support
 for v4.7
Message-ID: <1461601876-25288-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC guys,

Based on Arnd, suggestion this PR splits the previous one[1] into two
and drops clocksource and serial driver changes so that they can be
merged via respective trees independently.

Please pull !

Regards,
Sudeep

[1] http://www.spinics.net/lists/arm-kernel/msg497696.html
---

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/vexpress-for-v4.7/mps2

for you to fetch changes up to 4ef726d2f0e2f788bdf72f6cde64fcaaa26dcb66:

  MAINTAINERS: Update ARM Versatile Express platform entry (2016-04-25 14:11:16 +0100)

----------------------------------------------------------------
ARMv7 Cortex-M Prototyping System (MPS2) support

Basic support for ARM Versatile Express Cortex-M Prototyping System
(V2M-MPS2). ucLinux can be now run on both the hardware and FVP models
with Cortex-M3/M4/M7 configurations (Vladimir Murzin)

----------------------------------------------------------------
Vladimir Murzin (5):
      ARM: vexpress/mps2: introduce MPS2 platform
      ARM: configs: add MPS2 defconfig
      ARM: dts: introduce MPS2 AN385/AN386
      ARM: dts: introduce MPS2 AN399/AN400
      MAINTAINERS: Update ARM Versatile Express platform entry

 MAINTAINERS                          |   1 +
 arch/arm/Kconfig                     |  12 ++
 arch/arm/Makefile                    |   1 +
 arch/arm/boot/dts/Makefile           |   3 +
 arch/arm/boot/dts/mps2-an385.dts     |  92 +++++++++++++
 arch/arm/boot/dts/mps2-an399.dts     |  92 +++++++++++++
 arch/arm/boot/dts/mps2.dtsi          | 241 +++++++++++++++++++++++++++++++++++
 arch/arm/configs/mps2_defconfig      | 109 ++++++++++++++++
 arch/arm/mach-vexpress/Makefile      |   4 +-
 arch/arm/mach-vexpress/Makefile.boot |   3 +
 arch/arm/mach-vexpress/v2m-mps2.c    |  21 +++
 11 files changed, 578 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/mps2-an385.dts
 create mode 100644 arch/arm/boot/dts/mps2-an399.dts
 create mode 100644 arch/arm/boot/dts/mps2.dtsi
 create mode 100644 arch/arm/configs/mps2_defconfig
 create mode 100644 arch/arm/mach-vexpress/Makefile.boot
 create mode 100644 arch/arm/mach-vexpress/v2m-mps2.c
