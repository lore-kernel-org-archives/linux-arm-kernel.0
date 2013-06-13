From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 16:00:24 +0900
Subject: [GIT PULL 00/12] Renesas USB updates for v3.11
Message-ID: <1371106836-25388-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

This pull request is based on a merge of renesas-soc-for-v3.11
and renesas-pinmux-for-v3.11 in order to provide pre-requisites.
You have previously pulled both of those tags.

I have put all of these patches into a single pull-request as
R8A7779/Marzen clean-up portion are tightly related and don't seem
to be easily broken out into e.g. board and soc components without
introducing bisection breakage.

This pull request will cause various conflicts though I believe all
of them are not difficult to resolve. The renesas-next-20130613 tag in
my tree illustrates how I have handled the conflicts with
both changes already in arm-soc and changes I intend to send
pull requests for in the near future.

The following changes since commit ae8b378faea7f04d4517b22f5d70d824adcbc4dc:

  Merge branches 'heads/pinmux' and 'heads/soc' into phy-rcar-usb-base (2013-06-11 14:58:57 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-phy-rcar-usb-for-v3.11

for you to fetch changes up to 1a87b01d3b18709ae240ec90ae612354dd44d9a9:

  ARM: shmobile: BOCK-W: add USB support (2013-06-11 16:12:53 +0900)

----------------------------------------------------------------
Renesas USB updates for v3.11

These updates are by Sergei Shtylyov to clean-up USB support
present for R8A7779/Marzen and then extend USB support coverage to
R8A7778/BOCK-W.

----------------------------------------------------------------
Sergei Shtylyov (12):
      ARM: shmobile: Marzen: move USB EHCI, OHCI, and PHY devices to R8A7779 code
      ehci-platform: add pre_setup() method to platform data
      ARM: shmobile: r8a7779: setup EHCI internal buffer
      phy-rcar-usb: remove EHCI internal buffer setup
      ARM: shmobile: r8a7779: remove USB PHY 2nd memory resource
      phy-rcar-usb: correct base address
      phy-rcar-usb: add platform data
      ARM: shmobile: Marzen: pass platform data to USB PHY device
      phy-rcar-usb: handle platform data
      phy-rcar-usb: add R8A7778 support
      ARM: shmobile: r8a7778: add USB support
      ARM: shmobile: BOCK-W: add USB support

 arch/arm/mach-shmobile/Kconfig                |   2 +
 arch/arm/mach-shmobile/board-bockw.c          |   8 ++
 arch/arm/mach-shmobile/board-marzen.c         | 181 +-----------------------
 arch/arm/mach-shmobile/clock-r8a7778.c        |   4 +
 arch/arm/mach-shmobile/include/mach/r8a7778.h |   3 +
 arch/arm/mach-shmobile/include/mach/r8a7779.h |   3 +
 arch/arm/mach-shmobile/setup-r8a7778.c        | 108 ++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7779.c        | 196 +++++++++++++++++++++++++-
 drivers/usb/host/ehci-platform.c              |   6 +
 drivers/usb/phy/Kconfig                       |  10 +-
 drivers/usb/phy/phy-rcar-usb.c                | 128 +++++++++++------
 include/linux/platform_data/usb-rcar-phy.h    |  28 ++++
 include/linux/usb/ehci_pdriver.h              |   4 +
 13 files changed, 450 insertions(+), 231 deletions(-)
 create mode 100644 include/linux/platform_data/usb-rcar-phy.h
