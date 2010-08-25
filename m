From: ssanap@marvell.com (Sachin Sanap)
Date: Wed, 25 Aug 2010 14:47:43 +0530
Subject: [PATCH 0/3] Enable Fast Ethernet on Aspenite.
Message-ID: <1282727863.6968.95.camel@pe-lt522.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Since the PXA168 Fast Ethernet driver is now in upstream, following is the 
series of 3 patches that will help get the Fast Ethernet driver functional 
on PXA168 based Aspenite boards.First patch adds MAX7312, second patch adds 
the necessary MFU pins, and third adds Ethernet specific initialization.

Sachin Sanap (3):
  pxa: Hookup MAX7312 thats connected to I2C.
  [ARM] pxa: MFU pin configuration to support Fast ethernet.
  net: add Fast Ethernet driver for PXA168.

 arch/arm/mach-mmp/aspenite.c                |   81 ++-
 arch/arm/mach-mmp/include/mach/devices.h    |    1 +
 arch/arm/mach-mmp/include/mach/mfp-pxa168.h |   19 +
 arch/arm/mach-mmp/include/mach/pxa168.h     |    5 +
 arch/arm/mach-mmp/include/mach/pxa168_eth.h |   18 +
 arch/arm/mach-mmp/include/mach/regs-apmu.h  |    1 +
 arch/arm/mach-mmp/pxa168.c                  |    3 +
 drivers/net/Kconfig                         |   10 +
 drivers/net/Makefile                        |    1 +
 drivers/net/pxa168_eth.c                    | 1732 +++++++++++++++++++++++++++
 10 files changed, 1869 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-mmp/include/mach/pxa168_eth.h
 create mode 100644 drivers/net/pxa168_eth.c
