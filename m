From: tony@atomide.com (Tony Lindgren)
Date: Fri, 12 Feb 2016 13:20:07 -0800
Subject: [PATCHv5 0/2] Clock driver for dm814x and dra62x ADPLL
Message-ID: <1455312009-808-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here's a clock driver for the ADPLL on dm814x and dra62x. It's still
in read-only mode for the PLL, but is already usable with the gates
and dividers and allows us to add devices like MMC and USB.

Regards,

Tony

Tony Lindgren (2):
  dt-bindings: clock: adpll: Add binding documentation for TI adpll
  clk: ti: Add support for dm814x ADPLL

 .../devicetree/bindings/clock/ti/adpll.txt         |  43 +
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/ti/Kconfig                             |   6 +
 drivers/clk/ti/Makefile                            |   2 +
 drivers/clk/ti/adpll.c                             | 983 +++++++++++++++++++++
 drivers/clk/ti/clk-814x.c                          |  53 ++
 6 files changed, 1088 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/adpll.txt
 create mode 100644 drivers/clk/ti/Kconfig
 create mode 100644 drivers/clk/ti/adpll.c

-- 
2.7.0
