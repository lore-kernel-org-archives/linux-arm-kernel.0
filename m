From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  2 Sep 2015 16:38:03 +0100
Subject: [PATCH v3 0/6] remoteproc: Add driver for STMicroelectronics platforms
Message-ID: <1441208289-17330-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ST's platforms often have multiple co-processors (usually ST40s or ST231s)
on-board.  This provides the Linux-side infrastructure to flash and boot
them successfully.
  
This set has been tested on an STiH410-B2120.
  
v2 => v3:
 - Generify syscon property (st,syscfg-boot => st,syscfg-boot)
 - Rename IP in DT bindings doc (Remote Processor => Co-Processor)
 - Remove superfluous 'clock-names' property
 - Remove superfluous 'reg-names' property
 - Populate MAINTAINERS
 - Clean-up DTS formatting
 - Use strings in debugfs to control procs ('1|0' => 'start|stop')
 - Align copyright statement with MODULE() macros
 - Rename driver data structure ('st_rproc' => 'ddata')
 - Addition of a full error path in .start()

v1 => v2:
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

Lee Jones (6):
  ARM: STi: Add DT defines for co-processor reset lines
  remoteproc: dt: Provide bindings for ST's Remote Processor Controller
    driver
  remoteproc: Supply controller driver for ST's Remote Processors
  remoteproc: debugfs: Add ability to boot remote processor using
    debugfs
  ARM: STiH407: Add nodes for RemoteProc
  MAINTAINERS: Add ST's Remote Processor Driver to ARM/STI ARCHITECTURE

 .../devicetree/bindings/remoteproc/st-rproc.txt    |  35 +++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/stih407-family.dtsi              |  40 +++
 drivers/remoteproc/Kconfig                         |   9 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/remoteproc_debugfs.c            |  34 +++
 drivers/remoteproc/st_remoteproc.c                 | 307 +++++++++++++++++++++
 .../dt-bindings/reset-controller/stih407-resets.h  |   4 +
 8 files changed, 431 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/st-rproc.txt
 create mode 100644 drivers/remoteproc/st_remoteproc.c

-- 
1.9.1
