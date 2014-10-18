From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 18 Oct 2014 10:32:49 +0000
Subject: [PATCH RFC V3 0/3] mxs: add ocotp support for i.MX23 and i.MX28
Message-ID: <1413628372-2809-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series brings readonly support for the On Chip OTP cells in the 
i.MX23 and i.MX28 processor. The driver uses files (one for each cell) 
in sysfs as interface.

This series based on the second version of the patches from 
Christoph G. Baumann, but without write support which is too invasive.

The driver has been tested only with a i.MX28 board, so feedback from 
i.MX23 users are very welcome.

changes in V3:
- drop write support
- take care of i.MX23 which has less registers
- drop unnecessary header file
- move static variables into driver data
- add devicetree probing
- fix missing bank closing in error case
- use kobj from platform device for sysfs
- add SYSFS to Kconfig
- add binding file
- code cleanup

Stefan Wahren (3):
  mxs: add binding for fsl ocotp
  mxs: add driver for ocotp in i.MX23 and i.MX28
  mxs: enable ocotp for i.MX23 and i.MX28

 .../devicetree/bindings/misc/fsl,octop.txt         |   14 +
 arch/arm/boot/dts/imx23.dtsi                       |    3 +-
 arch/arm/boot/dts/imx28.dtsi                       |    3 +-
 drivers/misc/Kconfig                               |   13 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/fsl_ocotp.c                           |  332 ++++++++++++++++++++
 6 files changed, 362 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/fsl,octop.txt
 create mode 100644 drivers/misc/fsl_ocotp.c

-- 
1.7.9.5
