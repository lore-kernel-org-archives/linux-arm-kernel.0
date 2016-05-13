From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 May 2016 18:16:05 +0200
Subject: [GIT PULL] ARM: SoC fixes for 4.6
Message-ID: <2596349.2VGvIuv4pS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 44549e8f5eea4e0a41b487b63e616cb089922b99:

  Linux 4.6-rc7 (2016-05-08 14:38:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 8a934ccbf90959877beec27780469e85f1c3f101:

  Merge tag 'at91-fixes2' of git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91 into fixes (2016-05-12 17:44:53 +0200)

----------------------------------------------------------------
Three more bug fixes for ARM SoCs this week:

- The Atmel sama5d2 was registering the wrong NFC device type
- On Atmel sam9x5, the power management controller had an incorrect
  register area size
- On ARM64 Allwinner machine was not secting the generic irqchip
  code, causing build errors in some configurations

----------------------------------------------------------------
Arnd Bergmann (2):
      Merge tag 'at91-fixes' of git://git.kernel.org/.../nferre/linux-at91 into fixes
      Merge tag 'at91-fixes2' of git://git.kernel.org/.../nferre/linux-at91 into fixes

Boris Brezillon (1):
      ARM: dts: at91: sam9x5: Fix the memory range assigned to the PMC

Suzuki K Poulose (1):
      arm64/sunxi: 4.6-rc1: Add dependency on generic irq chip

Wenyou Yang (1):
      ARM: dts: at91: sama5d2: use "atmel,sama5d3-nfc" compatible for nfc

 arch/arm/boot/dts/at91sam9x5.dtsi | 2 +-
 arch/arm/boot/dts/sama5d2.dtsi    | 2 +-
 arch/arm64/Kconfig.platforms      | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)
