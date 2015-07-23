From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Thu, 23 Jul 2015 15:50:59 -0700
Subject: [RFC 0/3] Adding support for Zynq PL reset controller.
Message-ID: <1437691862-21312-1-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

while trying to get the devicetree overlays working using Alan's
simple-fpga-bus I couldn't find a way to independently reset
parts of the PL logic. I might have missed something and this
exists already somewhere, in that case, oh well ...

If S?ren or Michael could take a look at this to let me know
if this is fundamentally wrong, that would be great.

Thanks,

Moritz

Moritz Fischer (3):
  docs: dts: Added documentation for Xilinx Zynq PL Reset bindings.
  dts: zynq: Add devicetree entry for PL reset controller.
  reset: reset-zynq-pl: Adding support for Xilinx Zynq PL reset.

 .../devicetree/bindings/reset/zynq-reset-pl.txt    |  13 ++
 arch/arm/boot/dts/zynq-7000.dtsi                   |   6 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-zynq-pl.c                      | 142 +++++++++++++++++++++
 4 files changed, 162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
 create mode 100644 drivers/reset/reset-zynq-pl.c

-- 
2.4.3
