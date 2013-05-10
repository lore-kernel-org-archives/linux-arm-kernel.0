From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri, 10 May 2013 10:31:30 -0700
Subject: [PATCH RFC] User space clock driver
Message-ID: <1368207091-32538-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

is there any interest in exposing clock controls to userspace?
On Zynq we need/want this for a couple of clocks which are forwarded to
the FPGA part of the chip, in case no real device driver is taking care
of the clocks.
Additionally I can see this help debugging here and there. E.g. it can
be used to trigger rate change notifications. Hence I started this as a
generic driver instead of limiting it to my primary Zynq use-case.

The current state allows me to control the FPGA clocks on Zynq (other
clocks should work as well), so the functionality is basically there,
but I appreciate all feedback on the implementation. I suspect there
are better/other ways to do this.

	Thanks,
	S?ren

Soren Brinkmann (1):
  clk: Introduce userspace clock driver

 .../devicetree/bindings/clock/clk-userspace.txt    |   7 +
 drivers/clk/Kconfig                                |   9 ++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-userspace.c                        | 169 +++++++++++++++++++++
 4 files changed, 186 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/clk-userspace.txt
 create mode 100644 drivers/clk/clk-userspace.c

-- 
1.8.2.3
