From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 28 Aug 2015 11:31:47 +0100
Subject: [PATCH v2 0/4] remoteproc: Add driver for STMicroelectronics platforms
Message-ID: <1440757911-9120-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ST's platforms often have multiple co-processors (usually ST40s or ST231s)
on-board.  This provides the Linux-side infrastructure to flash and boot
them successfully.
 
This set has been tested on an STiH410-B2120.

v1 = v2:
 - Remove Linux implementation specific comment from binding document
 - Force debugfs '0' to shutdown co-processor - rather than !1
 - Supply more detailed commit message
 - Propagate errors back from .stop()
 - Review GPL wording
 - Supply original author's SoBs

Lee Jones (4):
  ARM: STiH407: Add nodes for RemoteProc
  remoteproc: dt: Provide bindings for ST's Remote Processor Controller
    driver
  remoteproc: Supply controller driver for ST's Remote Processors
  remoteproc: debugfs: Add ability to boot remote processor using
    debugfs

 .../devicetree/bindings/remoteproc/st-rproc.txt    |  35 +++
 arch/arm/boot/dts/stih407-family.dtsi              |  48 ++++
 drivers/remoteproc/Kconfig                         |   9 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/remoteproc_debugfs.c            |  29 ++
 drivers/remoteproc/st_remoteproc.c                 | 301 +++++++++++++++++++++
 6 files changed, 423 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/st-rproc.txt
 create mode 100644 drivers/remoteproc/st_remoteproc.c

-- 
1.9.1
