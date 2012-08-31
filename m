From: horms@verge.net.au (Simon Horman)
Date: Fri, 31 Aug 2012 09:34:35 +0900
Subject: [GIT PULL] Renesas ARM-based SoC: Marzen and r8a7779 for 3.7
Message-ID: <1346373285-19588-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following enhancements to the Marzen board
and r8a7779 SoC by Phil Edworthy, Morimoto-san and myself for 3.7.

* This pull request is based on the usb-next branch of Greg KH's USB tree,
  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git,
  which is based on v3.6-rc3.

  This is to satisfy compile-time dependencies.
  Please let me know if you would like this handled a different way.

----------------------------------------------------------------
The following changes since commit a7bdf7fa33127bf08eb0810698bca607a9462df4:

  Merge v3.6-rc3 into usb-next (2012-08-27 07:15:30 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git marzen

for you to fetch changes up to 922bdac2247841fff1ace215b45eb165f6346a6f:

  ARM: shmobile: marzen: enable thermal sensor (2012-08-31 09:24:15 +0900)

----------------------------------------------------------------
Kuninori Morimoto (7):
      ARM: shmobile: r8a7779: PFC rename PENCx -> USB_PENCx
      ARM: shmobile: r8a7779: add USB common phy initializer
      ARM: shmobile: r8a7779: add USB EHCI clock support
      ARM: shmobile: r8a7779: add USB OHCI clock support
      ARM: shmobile: marzen: add USB EHCI driver support
      ARM: shmobile: marzen: fixup regulator id for smsc911x
      ARM: shmobile: marzen: enable thermal sensor

Phil Edworthy (2):
      r8a7779: add SDHI clock support
      marzen: add SDHI0 support

Simon Horman (1):
      ARM: mach-shmobile: marzen: defconfig update

 arch/arm/configs/marzen_defconfig             |  25 +++--
 arch/arm/mach-shmobile/Kconfig                |   1 +
 arch/arm/mach-shmobile/board-marzen.c         | 156 +++++++++++++++++++++++++-
 arch/arm/mach-shmobile/clock-r8a7779.c        |  18 ++-
 arch/arm/mach-shmobile/include/mach/common.h  |   1 +
 arch/arm/mach-shmobile/include/mach/r8a7779.h |   2 +-
 arch/arm/mach-shmobile/pfc-r8a7779.c          |  16 +--
 arch/arm/mach-shmobile/setup-r8a7779.c        |  93 +++++++++++++++
 8 files changed, 294 insertions(+), 18 deletions(-)
