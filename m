From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Fri, 24 Jul 2015 17:21:19 -0700
Subject: [RFCv2 0/3] Adding support for Zynq Reset Controller
Message-ID: <1437783682-13632-1-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I went ahead and generalized it to support all the resets I could
find in the TRM. I don't know if all of them are sensible, so we 
need to carfully double check that. I also tried to add in the stuff
that was pointed out in v1.

If this looks good enough for a patch let me know.

Thanks for your feedback,

Moritz

Moritz Fischer (3):
  docs: dts: Added documentation for Xilinx Zynq Reset Controller
    bindings.
  dts: zynq: Add devicetree entry for Xilinx Zynq reset controller.
  reset: reset-zynq: Adding support for Xilinx Zynq reset controller.

 .../devicetree/bindings/reset/zynq-reset-pl.txt    |  13 ++
 arch/arm/boot/dts/zynq-7000.dtsi                   |  43 ++++++-
 arch/arm/boot/dts/zynq-parallella.dts              |   2 +-
 arch/arm/boot/dts/zynq-zc702.dts                   |   2 +-
 arch/arm/boot/dts/zynq-zc706.dts                   |   2 +-
 arch/arm/boot/dts/zynq-zed.dts                     |   2 +-
 arch/arm/boot/dts/zynq-zybo.dts                    |   2 +-
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-zynq.c                         | 142 +++++++++++++++++++++
 include/dt-bindings/reset/xlnx,zynq-reset.h        |  94 ++++++++++++++
 10 files changed, 297 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
 create mode 100644 drivers/reset/reset-zynq.c
 create mode 100644 include/dt-bindings/reset/xlnx,zynq-reset.h

-- 
2.4.3
