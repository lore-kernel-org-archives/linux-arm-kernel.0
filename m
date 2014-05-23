From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 23 May 2014 17:29:57 -0400
Subject: [GIT PULL] ARM: Keystone reset driver 3.16
Message-ID: <1400880597-7516-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arm-soc folks,

Please pull below keystone reset driver for 3.16 . To avoid merge conflict
with earlier keystone-soc pull request[1], I have based the subject pull
request on top of it. It merges cleanly with arm-soc 'next/soc2' head. Please
apply it against 'next/soc2'. Thanks 


The following changes since commit 14f3791439b5a6cf12127fb80204265533d92664:

  ARM: keystone: Update the dma offset for non-dt platform devices (2014-05-08 15:43:33 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-reset

for you to fetch changes up to c124d557c820e6e4926ae1de1ddc109024a92f52:

  ARM: configs: keystone: enable reset driver support (2014-05-23 16:53:58 -0400)

----------------------------------------------------------------
Keystone Reset driver for 3.16

- Keystone Reser device driver
- Removal of now un-necessary reset machine code
- dts updates for keystone reset driver

----------------------------------------------------------------
Ivan Khoronzhuk (6):
      power: reset: keystone-reset: introduce keystone reset driver
      Documentation: dt: add bindings for keystone pll control controller
      Documentation: dt: add bindings for keystone reset driver
      ARM: keystone: remove redundant reset stuff
      ARM: dts: keystone: update reset node to work with reset driver
      ARM: configs: keystone: enable reset driver support

 .../bindings/clock/ti-keystone-pllctrl.txt         |   20 +++
 .../bindings/power/reset/keystone-reset.txt        |   67 ++++++++
 arch/arm/boot/dts/keystone.dtsi                    |   14 +-
 arch/arm/configs/keystone_defconfig                |    3 +
 arch/arm/mach-keystone/keystone.c                  |   34 ----
 drivers/power/reset/Kconfig                        |    8 +
 drivers/power/reset/Makefile                       |    1 +
 drivers/power/reset/keystone-reset.c               |  166 ++++++++++++++++++++
 8 files changed, 278 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti-keystone-pllctrl.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/keystone-reset.txt
 create mode 100644 drivers/power/reset/keystone-reset.c

Regards,
Santosh
[1] http://www.spinics.net/lists/arm-kernel/msg330521.html
