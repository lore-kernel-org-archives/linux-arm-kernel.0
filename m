From: rjui@broadcom.com (Ray Jui)
Date: Tue, 9 Dec 2014 18:18:09 -0800
Subject: [PATCH v2 0/4] Add I2C support to Broadcom iProc
In-Reply-To: <Ray Jui <rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
Message-ID: <1418177893-22094-1-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the initial I2C support for Broadcom iProc family of
SoCs.

The iProc I2C controller has separate internal TX and RX FIFOs, each has a
size of 64 bytes. The iProc I2C controller supports two bus speeds including
standard mode (100 kHz) and fast mode (400 kHz)

Changes from v1:
 - Fix function argument parenthesis
 - Get rid of redundant driver owner field

Ray Jui (4):
  i2c: iProc: define Broadcom iProc I2C binding
  i2c: iproc: Add Broadcom iProc I2C Driver
  ARM: mach-bcm: Enable I2C support for iProc
  ARM: dts: add I2C device nodes for Broadcom Cygnus

 .../devicetree/bindings/i2c/brcm,iproc-i2c.txt     |   37 ++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   20 +
 arch/arm/mach-bcm/Kconfig                          |    1 +
 drivers/i2c/busses/Kconfig                         |    9 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-bcm-iproc.c                 |  502 ++++++++++++++++++++
 6 files changed, 570 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
 create mode 100644 drivers/i2c/busses/i2c-bcm-iproc.c

-- 
1.7.9.5
