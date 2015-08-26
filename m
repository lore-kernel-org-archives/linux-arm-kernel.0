From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 26 Aug 2015 14:07:59 +0100
Subject: [PATCH 0/4] remoteproc: Add driver for STMicroelectronics platforms
Message-ID: <1440594483-29601-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ST's platforms often have multiple co-processors (usually ST40s or ST231s)
on-board.  This provides the Linux-side infrastructure to flash and boot
them successfully.

This set has been tested on an STiH410-B2120.

Lee Jones (4):
  remoteproc: dt: Provide bindings for ST's Remote Processor Controller
    driver
  remoteproc: Supply controller driver for ST's Remote Processors
  ARM: STiH407: Add nodes for RemoteProc
  remoteproc: debugfs: Add ability to boot remote processor using
    debugfs

 .../devicetree/bindings/remoteproc/st-rproc.txt    |  38 +++
 arch/arm/boot/dts/stih407-family.dtsi              |  48 ++++
 drivers/remoteproc/Kconfig                         |   9 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/remoteproc_debugfs.c            |  25 ++
 drivers/remoteproc/st_remoteproc.c                 | 300 +++++++++++++++++++++
 6 files changed, 421 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/st-rproc.txt
 create mode 100644 drivers/remoteproc/st_remoteproc.c

-- 
1.9.1
