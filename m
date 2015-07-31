From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Thu, 30 Jul 2015 18:13:53 -0700
Subject: [RFCv3 0/4] Adding support for Zynq Reset Controller
Message-ID: <1438305237-18497-1-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I made another RFC addressing most of the feedback that I got so far.

I haven't completly given up on S?ren's idea of getting rid of having
some sort of protection against people using wrong bits by accident,
but haven't come up with a clean way to do so yet (especially when looking at
the possiblity of also supporting the upcoming Zynq's reset controller).

I changed the reg property to <0x200 0x48> but I'm not sure if that's correct.
At 0x24C there's the RS_AWDT_CTRL which is not a reset. The last legit one
is A9_CPU_RST_CTRL at 0x244.

As Michal requested I removed the #include syntax from the devicetree bindings.

Thanks for your reviews,

Moritz

Moritz Fischer (4):
  docs: dts: Added documentation for Xilinx Zynq Reset Controller
    bindings.
  dts: zynq: Add devicetree entry for Xilinx Zynq reset controller.
  reset: reset-zynq: Adding support for Xilinx Zynq reset controller.
  ARM: zynq: Select ARCH_HAS_RESET_CONTROLLER

 .../devicetree/bindings/reset/zynq-reset.txt       |  68 +++++++++
 arch/arm/boot/dts/zynq-7000.dtsi                   |   8 ++
 arch/arm/mach-zynq/Kconfig                         |   1 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-zynq.c                         | 155 +++++++++++++++++++++
 5 files changed, 233 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/zynq-reset.txt
 create mode 100644 drivers/reset/reset-zynq.c

-- 
2.4.3
