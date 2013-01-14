From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 14 Jan 2013 18:12:38 +0800
Subject: [PATCH v3 0/3] Fix the Build error for fsl_mxc_udc.c
Message-ID: <1358158361-25550-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes for v3:
- Split the one big patch into three patches

Changes for v2:
- Add const for fsl_udc_devtype
- Do ioremap for phy address at fsl-mxc-udc

Peter Chen (3):
  usb: fsl-mxc-udc: replace cpu_is_xxx() with platform_device_id
  usb: fsl_mxc_udc: replace MX35_IO_ADDRESS to ioremap
  ARM: i.MX clock: Change the connection-id for fsl-usb2-udc

 arch/arm/mach-imx/clk-imx25.c                     |    6 +-
 arch/arm/mach-imx/clk-imx27.c                     |    6 +-
 arch/arm/mach-imx/clk-imx31.c                     |    6 +-
 arch/arm/mach-imx/clk-imx35.c                     |    6 +-
 arch/arm/mach-imx/clk-imx51-imx53.c               |    6 +-
 arch/arm/mach-imx/devices/devices-common.h        |    1 +
 arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c |   15 +++---
 drivers/usb/gadget/fsl_mxc_udc.c                  |   23 +++++----
 drivers/usb/gadget/fsl_udc_core.c                 |   52 +++++++++++++-------
 drivers/usb/gadget/fsl_usb2_udc.h                 |   13 ++++--
 include/linux/fsl_devices.h                       |    8 +++
 11 files changed, 87 insertions(+), 55 deletions(-)
