From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:03:54 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.19
Message-ID: <cover.1532086504.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v4.19.


The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-defconfig-for-v4.19

for you to fetch changes up to e82c98d0448c60706a8024d460eadb9d7402dcba:

  ARM: multi_v7_defconfig: Enable support for RZN1D-DB (2018-07-13 10:15:20 +0200)

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

* Set CONFIG_LOCALVERSION to shmobile_defconfig

  This follows what appears to be common practice in defconfigs
  and allows easier management of the kernel flavour at run-time.

* Disable long deprecated /sbin/hotplug helper

* Enable reset controller support

  This is to give better test coverage.
  This may be used by reset controller support in the Renesas CPG/MSSR
  driver when used by R-Car Gen2 and RZ/G1 SoCs.

* Enable MTD command line partition parsing

  This is in preparation for removing MTD partitioning from the DTs.
  The arguments for moving partition information from DT to the command
  line are:
  - Partitions do not describe the hardware itself
  - Using the command line offers greater flexibility

----------------------------------------------------------------
Geert Uytterhoeven (6):
      ARM: shmobile: defconfig: Drop NET_VENDOR_<FOO>=n
      ARM: shmobile: defconfig: Enable reset controller support
      ARM: shmobile: defconfig: Enable support for RZN1D-DB
      ARM: shmobile: defconfig: Disable /sbin/hotplug fork-bomb
      ARM: shmobile: defconfig: Set CONFIG_LOCALVERSION
      ARM: multi_v7_defconfig: Enable support for RZN1D-DB

Marek Vasut (1):
      ARM: shmobile: defconfig: Enable MTD command line partition parsing

 arch/arm/configs/multi_v7_defconfig |  1 +
 arch/arm/configs/shmobile_defconfig | 19 +++++--------------
 2 files changed, 6 insertions(+), 14 deletions(-)
