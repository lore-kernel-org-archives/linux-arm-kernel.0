From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 14 Feb 2014 17:14:59 -0300
Subject: [PATCH 0/4] Core Divider support for Armada 375 SoC
Message-ID: <1392408903-31237-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These changes add support in the Core Divider clock driver, to support
the newly introduced Armada 375 SoC.

The first and second patches, are just cosmetic and documentation
improvements.

The third patch adds the required infrastructure to support more SoCs.

Finally, the fourth patch make use of the infrastructure to add the
Armada 375 support. Compared to the previously supported Armada 370 and
Armada XP Core Divider clocks, the Armada 375 SoC Core Dividers have
a different register layout and lacks the capability to gate a clock.

The core and clock support for the Armada 375 SoC has been submitted recently,
and we're aiming at having this merged for 3.15, if at all possible.

Special thanks to Thomas for cooking this!

Thomas Petazzoni (4):
  clk: mvebu: do not copy the contents of clk_corediv_desc
  clk: mvebu: add a little bit of documentation about data structures
  clk: mvebu: refactor corediv driver to support more SoC
  clk: mvebu: add Armada 375 support to the corediv clock driver

 drivers/clk/mvebu/clk-corediv.c | 131 ++++++++++++++++++++++++++++++----------
 1 file changed, 100 insertions(+), 31 deletions(-)

-- 
1.8.1.5
