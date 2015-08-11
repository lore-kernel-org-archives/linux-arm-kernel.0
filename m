From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 11 Aug 2015 13:30:15 +0000
Subject: [PATCH V5 0/3] nvmem: add ocotp support for i.MX23 and i.MX28
Message-ID: <1439299818-8495-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series brings read-only support for the On-Chip OTP cells
in the i.MX23 and i.MX28 processor.

changes in V5:
- rebase to char-misc-next
- add nvmem prefix to module name
- set status in dtsi files

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
  ARM: mxs: enable ocotp for i.MX23 and i.MX28

 .../devicetree/bindings/nvmem/mxs-ocotp.txt        |   24 ++
 arch/arm/boot/dts/imx23.dtsi                       |    7 +-
 arch/arm/boot/dts/imx28.dtsi                       |    7 +-
 drivers/nvmem/Kconfig                              |   11 +
 drivers/nvmem/Makefile                             |    2 +
 drivers/nvmem/mxs-ocotp.c                          |  252 ++++++++++++++++++++
 6 files changed, 299 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mxs-ocotp.txt
 create mode 100644 drivers/nvmem/mxs-ocotp.c

-- 
1.7.9.5
