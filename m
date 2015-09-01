From: olof@lixom.net (Olof Johansson)
Date: Mon, 31 Aug 2015 17:07:04 -0700
Subject: [GIT PULL 1/7] ARM: SoC non-urgent fixes for 4.3
In-Reply-To: <1441066030-23225-1-git-send-email-olof@lixom.net>
References: <1441066030-23225-1-git-send-email-olof@lixom.net>
Message-ID: <1441066030-23225-2-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We normally collect non-urgent fixes during the release cycle and queue them for the merge window.

This time around the list is short (in part because some have gone in other
branches).

- Maintainers addition for bcm2835
- IRQ number fix for orion5x (been present since 3.18)
- DT fix for display on exynos3250
- Exynos fix to use of IOMEM_ERR_PTR properly

----------------------------------------------------------------

The following changes since commit 64291f7db5bd8150a74ad2036f1037e6a0428df2:

  Linux 4.2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes-nc

for you to fetch changes up to 330349fae46f8400e86ef98ee05af4ba13466f49:

  Merge tag 'mvebu-fixes-4.2-1' of git://git.infradead.org/linux-mvebu into next/fixes-non-critical

----------------------------------------------------------------

Benjamin Cama (1):
      ARM: orion5x: fix legacy orion5x IRQ numbers

Eric Anholt (2):
      MAINTAINERS: Add myself as a bcm2835 co-maintainer.
      MAINTAINERS: Explicitly add linux-arm-kernel for bcm2835

Hyungwon Hwang (1):
      ARM: dts: fix clock-frequency of display timing0 for exynos3250-rinato

Krzysztof Kozlowski (1):
      ARM: EXYNOS: Use IOMEM_ERR_PTR when function returns iomem

Olof Johansson (3):
      Merge tag 'samsung-non-critical-1' of git://git.kernel.org/.../kgene/linux-samsung into next/fixes-non-critical
      Merge tag 'arm-soc/for-4.3/maintainers' of http://github.com/broadcom/stblinux into next/fixes-non-critical
      Merge tag 'mvebu-fixes-4.2-1' of git://git.infradead.org/linux-mvebu into next/fixes-non-critical


 MAINTAINERS                               |  2 +
 arch/arm/Kconfig                          |  1 +
 arch/arm/boot/dts/exynos3250-rinato.dts   |  2 +-
 arch/arm/mach-exynos/platsmp.c            |  2 +-
 arch/arm/mach-orion5x/include/mach/irqs.h | 64 +++++++++++++-------------
 arch/arm/mach-orion5x/irq.c               |  4 +-
 6 files changed, 39 insertions(+), 36 deletions(-)
