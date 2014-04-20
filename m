From: punnaiah.choudary.kalluri@xilinx.com (Punnaiah Choudary Kalluri)
Date: Sun, 20 Apr 2014 21:57:03 +0530
Subject: [RFC PATCH 0/2] usb: Reuse fsl driver code for synopsys usb controller
Message-ID: <7aed4ee6-69e7-4f9f-9f45-675bc695089c@CO9EHSMHS031.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zynq soc contains a dual role usb controller and this IP is from synopsys. We
observed that there is driver available for this controller from freescale and
decided to reuse this driver for zynq use.

Here is the link for zynq soc TRM. Please refer chapter 15 for usb controller
related information.
http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf

The following series of patches add initial support for zynq soc in fsl gadget controller
driver and fsl host controller driver.

Based on these patches, I have the following concerns and sugesstions

Since the freescale usb driver is for synopsys IP, Please consider rebranding
this driver name and config options to reflect that it is a sysnopsys IP. So
that other vendors who using this IP can reuse thie driver.

Also the ehci-fsl.c is for powerpc based soc's, and zynq is ARM based, i have
protected the code which is specifc to freescale with CONFIG_FSL_SOC. Please
suggest if there is a better way of doing this?

Punnaiah Choudary Kalluri (2):
  usb: gadget: fsl_udc: Add support for zynq usb device controller
  usb: ehci-fsl: Add support for zynq usb host controller

 drivers/usb/gadget/Kconfig        |    2 +-
 drivers/usb/gadget/Makefile       |    1 +
 drivers/usb/gadget/fsl_mxc_udc.c  |   21 ++++++++++++
 drivers/usb/gadget/fsl_udc_core.c |    5 +++
 drivers/usb/gadget/fsl_usb2_udc.h |    2 +-
 drivers/usb/host/Kconfig          |    2 +-
 drivers/usb/host/ehci-fsl.c       |   63 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/host/fsl-mph-dr-of.c  |    9 +++++
 8 files changed, 101 insertions(+), 4 deletions(-)

-- 
1.7.4
