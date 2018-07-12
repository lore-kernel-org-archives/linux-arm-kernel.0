From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 12 Jul 2018 18:39:53 +0200
Subject: [GIT PULL] ARM: mvebu: arm for v4.19 (#1)
Message-ID: <87y3egbe7a.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for arm for mvebu for v4.19.

Gregory

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-arm-4.19-1

for you to fetch changes up to 432c0254106a373bcc23b1bd3e0b7eb56929c0d9:

  ARM: mvebu_v7_defconfig: enable SFP support (2018-06-28 16:53:08 +0200)

----------------------------------------------------------------
mvebu arm for 4.19 (part 1)

defconfig update:
 - add NAND controller on multi_v7
 - add SFP support on mvebu_v7
code improvement:
 - remove potential call from invalid context in boot_secondary
 - allow using CONFIG_FORTIFY_SOURCE in pmsu.c

----------------------------------------------------------------
Baruch Siach (2):
      ARM: mvebu_v7_defconfig: sync defconfig
      ARM: mvebu_v7_defconfig: enable SFP support

Ethan Tuttle (1):
      ARM: mvebu: declare asm symbols as character arrays in pmsu.c

Gregory CLEMENT (1):
      ARM: multi_v7_defconfig: Add Marvell NAND controller support

Lucas Stach (1):
      ARM: mvebu: convert secondary CPU clock sync to hotplug state

 arch/arm/configs/multi_v7_defconfig |  1 +
 arch/arm/configs/mvebu_v7_defconfig | 13 +++-------
 arch/arm/mach-mvebu/platsmp.c       | 49 +++++++++++++++++--------------------
 arch/arm/mach-mvebu/pmsu.c          |  6 ++---
 include/linux/cpuhotplug.h          |  1 +
 5 files changed, 31 insertions(+), 39 deletions(-)
