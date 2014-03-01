From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Mar 2014 01:13:21 -0500
Subject: [GIT PULL] pinctrl: mvebu: driver changes for v3.15
Message-ID: <20140301061321.GU1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

Here's the pull request we talked about earlier in the week.  I've
merged them all into one branch as you requested.

This branch is currently included in mvebu/for-next which is included in
linux-next.  Both for testing.  This branch is only required for boot
testing.  There are no other dependencies.

This series does touch dove.dtsi, but doesn't conflict with anything we
are sending up this cycle.

If you need to rebase these, please let me know so I can pull them out
of mvebu/for-next.  We don't want a conflict in linux-next.  Also, in
the case of a rebase, if you could provide a topic branch for us to pull
in so we can continue testing, that would be much appreciated.

These changes have been in -next for 3 days.  Please pull.

thx,

Jason.


The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-pinctrl-3.15

for you to fetch changes up to 03366607962ced33f7f0253f5aa229f599ff7e01:

  Merge tag 'tags/for-mvebu-pinctrl-3xx' into mvebu/pinctrl (2014-03-01 05:50:51 +0000)

----------------------------------------------------------------

mvebu pinctrl changes for v3.15

 - various cleanup and refactorization
 - add drivers for the Armada 375, 380, and 385 SoCs
 - prepare dove for SoC code moving into mach-mvebu
 - DT documentation updates

----------------------------------------------------------------
Jason Cooper (3):
      Merge tag 'tags/for-mvebu-pinctrl-cleanup' into mvebu/pinctrl
      Merge tag 'tags/for-mvebu-pinctrl-dove' into mvebu/pinctrl
      Merge tag 'tags/for-mvebu-pinctrl-3xx' into mvebu/pinctrl

Sebastian Hesselbarth (23):
      pinctrl: mvebu: count unnamed controls and allocate name buffer
      pinctrl: mvebu: remove obsolete per-control name buffer allocation
      pinctrl: mvebu: identify generic controls by name
      pinctrl: mvebu: remove passing mvebu_mpp_ctrl to callbacks
      pinctrl: mvebu: add common mpp reg helper to mvebu pinctrl include
      pinctrl: mvebu: dove: provide generic mpp callbacks
      pinctrl: mvebu: kirkwood: provide generic mpp callbacks
      pinctrl: mvebu: armada-370: provide generic mpp callbacks
      pinctrl: mvebu: armada-xp: provide generic mpp callbacks
      pinctrl: mvebu: move resource allocation to SoC specific drivers
      pinctrl: mvebu: remove common get/set functions
      pinctrl: mvebu: dove: consolidate auto-numbered pmu mpp ranges
      pinctrl: mvebu: dove: reuse mpp_{set,get} in pmu callbacks
      devicetree: bindings: add missing Marvell Dove SoC documentation
      devicetree: bindings: update MVEBU pinctrl binding documentation
      ARM: dove: add additional pinctrl registers
      ARM: dove: add global-config register node
      pinctrl: mvebu: dove: request additional resources
      pinctrl: mvebu: dove: request syscon regmap for global registers
      pinctrl: mvebu: dove: use remapped mpp base registers
      pinctrl: mvebu: dove: use remapped mpp4 register
      pinctrl: mvebu: dove: use remapped pmu_mpp registers
      pinctrl: mvebu: dove: use global register regmap

Thomas Petazzoni (3):
      pinctrl: mvebu: remove MPP_REG_CTRL macro
      pinctrl: mvebu: add pin-muxing driver for the Marvell Armada 375
      pinctrl: mvebu: add pin-muxing driver for the Marvell Armada 380/385

 .../devicetree/bindings/arm/marvell,dove.txt       |  22 +
 .../pinctrl/marvell,armada-370-pinctrl.txt         |   1 +
 .../pinctrl/marvell,armada-375-pinctrl.txt         |  82 ++++
 .../pinctrl/marvell,armada-38x-pinctrl.txt         |  80 ++++
 .../bindings/pinctrl/marvell,armada-xp-pinctrl.txt |   1 +
 .../bindings/pinctrl/marvell,dove-pinctrl.txt      |   1 +
 .../bindings/pinctrl/marvell,kirkwood-pinctrl.txt  |   1 +
 .../bindings/pinctrl/marvell,mvebu-pinctrl.txt     |   2 +-
 arch/arm/boot/dts/dove.dtsi                        |  10 +-
 drivers/pinctrl/mvebu/Kconfig                      |   9 +
 drivers/pinctrl/mvebu/Makefile                     |   2 +
 drivers/pinctrl/mvebu/pinctrl-armada-370.c         |  20 +-
 drivers/pinctrl/mvebu/pinctrl-armada-375.c         | 459 ++++++++++++++++++++
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c         | 462 +++++++++++++++++++++
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c          |  24 +-
 drivers/pinctrl/mvebu/pinctrl-dove.c               | 403 ++++++++++--------
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c           |  25 +-
 drivers/pinctrl/mvebu/pinctrl-mvebu.c              | 122 ++----
 drivers/pinctrl/mvebu/pinctrl-mvebu.h              |  55 ++-
 19 files changed, 1489 insertions(+), 292 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell,dove.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-375.c
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-38x.c
