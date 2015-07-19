From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 19 Jul 2015 22:04:56 +0000
Subject: [PATCH V4 RFC 0/3] nvmem: add ocotp support for i.MX23 and i.MX28
Message-ID: <1437343499-16422-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series brings read-only support for the On-Chip OTP cells
in the i.MX23 and i.MX28 processor.

It has been a long time since V3 of this series [1]. The last version has been
rejected because there was no standard interface to the OTP data. So this
version bases on V7 of the new NVMEM framework [2] which required a nearly
complete rewrite of the driver.

[1] - http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/295228.html
[2] - http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/355652.html

changes in V4:
- rename fsl_ocotp.c to mxs-ocotp.c
- adapt driver to use NVMEM framework V7
- take care of hbus clock
- increase too small timeout
- implement a wait function
- use defines from stmp_device.h
- remove owner init
- more code cleanup

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
  DT: nvmem: add binding for mxs-ocotp
  nvmem: add driver for ocotp in i.MX23 and i.MX28
  mxs: enable ocotp for i.MX23 and i.MX28

 .../devicetree/bindings/nvmem/mxs-ocotp.txt        |   24 ++
 arch/arm/boot/dts/imx23.dtsi                       |    6 +-
 arch/arm/boot/dts/imx28.dtsi                       |    6 +-
 drivers/nvmem/Kconfig                              |   11 +
 drivers/nvmem/Makefile                             |    1 +
 drivers/nvmem/mxs-ocotp.c                          |  252 ++++++++++++++++++++
 6 files changed, 296 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mxs-ocotp.txt
 create mode 100644 drivers/nvmem/mxs-ocotp.c

-- 
1.7.9.5
