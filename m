From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jul 2018 14:04:13 +0200
Subject: [GIT PULL v2] Renesas ARM Based SoC Defconfig Updates for v4.19
Message-ID: <cover.1532346690.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v4.19.

Changes since v1:
* Dropped patch to set CONFIG_LOCALVERSION as requested by Olof
* Dropped patch to Enable MTD command line partition parsing as
  Olof has asked for more discussion on the related DTS change


The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-defconfig-for-v4.19

for you to fetch changes up to b036e6420b9aed3498cbd0429f12300139cc5a28:

  ARM: multi_v7_defconfig: Enable support for RZN1D-DB (2018-07-23 13:48:02 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v4.19

multi_v7_defconfig and shmobile_defconfig Enhancement:

* Enable support for recently upstreamed RZN1D-DB board
  in multi_v7_defconfig and shmobile_defconfig. This is
  to give better test coverage.

shmobile_defconfig Clean-Up:

* Drop NET_VENDOR_<FOO>=n

  This reduces the size of the defconfig without any change in the
  resulting kernel config.

shmobile_defconfig Enhancements:

* Disable long deprecated /sbin/hotplug helper

* Enable reset controller support

  This is to give better test coverage.
  This may be used by reset controller support in the Renesas CPG/MSSR
  driver when used by R-Car Gen2 and RZ/G1 SoCs.

----------------------------------------------------------------
Geert Uytterhoeven (5):
      ARM: shmobile: defconfig: Drop NET_VENDOR_<FOO>=n
      ARM: shmobile: defconfig: Enable reset controller support
      ARM: shmobile: defconfig: Enable support for RZN1D-DB
      ARM: shmobile: defconfig: Disable /sbin/hotplug fork-bomb
      ARM: multi_v7_defconfig: Enable support for RZN1D-DB

 arch/arm/configs/multi_v7_defconfig |  1 +
 arch/arm/configs/shmobile_defconfig | 17 +++--------------
 2 files changed, 4 insertions(+), 14 deletions(-)
