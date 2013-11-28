From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 18:08:05 +0900
Subject: [PATCH 00/16] Renesas ARM based SoC defconfig updates for v3.14
Message-ID: <cover.1385629477.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Olof, and Arnd,

please consider these Renesas ARM based SoC defconfig updates for v3.14.

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v3.14

for you to fetch changes up to 577092b3d11530acd8467074f6ea7e2dd36b5028:

  ARM: shmobile: kzm9d: Enable AUTO_ZRELADDR in defconfig (2013-11-24 15:13:43 +0900)

----------------------------------------------------------------
Renesas ARM based SoC defconfig updates for v3.14

* Add Genmai defconfig
  - The board was added in v3.13 but the defconfig missed the cut
* Enable AUTO_ZRELADDR for kzm9d board
* Enable HPB-DMAC, PACKET, VFP on bockw and marzen boards
* Do not disable INOTIFY_USER on bockw or marzen boards
* Do not enable CONFIG_DEVTMPFS on bockw or marzen boards
* Do not enable CONFIG_SMC911X on marzen
  - That hardware does not exist on the marzen board
* Do not set command line on bockw or marzen boards
  - This is handled in the DTS
* Enable REGULATOR on bockw board

----------------------------------------------------------------
Kuninori Morimoto (1):
      ARM: shmobile: bockw: enable CONFIG_REGULATOR

Magnus Damm (1):
      ARM: shmobile: Genmai defconfig

Sergei Shtylyov (2):
      ARM: shmobile: marzen: enable HPB-DMAC in defconfig
      ARM: shmobile: bockw: enable HPB-DMAC in defconfig

Simon Horman (12):
      ARM: shmobile: bockw: Do not set command line in defconfig
      ARM: shmobile: marzen: Do not set command line in defconfig
      ARM: shmobile: bockw: Do not disable CONFIG_INOTIFY_USER in defconfig
      ARM: shmobile: marzen: Do not disable CONFIG_INOTIFY_USER in defconfig
      ARM: shmobile: bockw: Enable CONFIG_VFP in defconfig
      ARM: shmobile: marzen: Enable CONFIG_VFP in defconfig
      ARM: shmobile: bockw: Do not enable CONFIG_DEVTMPFS defconfig
      ARM: shmobile: marzen: Do not enable CONFIG_DEVTMPFS defconfig
      ARM: shmobile: bockw: Enable CONFIG_PACKET in defconfig
      ARM: shmobile: marzen: Enable CONFIG_PACKET in defconfig
      ARM: shmobile: marzen: Do not enable CONFIG_SMC911X in defconfig
      ARM: shmobile: kzm9d: Enable AUTO_ZRELADDR in defconfig

 arch/arm/configs/bockw_defconfig  |  10 ++--
 arch/arm/configs/genmai_defconfig | 116 ++++++++++++++++++++++++++++++++++++++
 arch/arm/configs/kzm9d_defconfig  |   1 +
 arch/arm/configs/marzen_defconfig |  10 ++--
 4 files changed, 126 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/configs/genmai_defconfig
