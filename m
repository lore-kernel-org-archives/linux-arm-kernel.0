From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 30 Sep 2013 18:03:26 -0300
Subject: [PATCH 0/4] Kirkwood: minor cleanups
Message-ID: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is just a small patchset containing minor cleanups for Kirkwood SoC
as a result of a review of the mach-dependent DT initialization code.

The first patch is a trivial cleanup, with no dependencies.

The second patch is also trivial, but given I don't have any boards
with PCIe to test, I would appreciate if someone could give it a try.

The third and fourth patch are related: the latter strictly depends on
the former. The idea behind these two patches is basically to convert
the "keep the ethernet clocks enabled by calling clk_enable()" hack
into a simpler and cleaner usage of the CLK_IGNORE_UNUSED flags which
prevent these clocks from being ever gated.

I've tested these two by building the ethernet driver as a module
and checking the MAC address is properly retained.

Any comments welcome.

Ezequiel Garcia (4):
  ARM: kirkwood: Remove unneeded MBus initialization
  ARM: kirkwood: Remove unneeded PCIe clock adding
  clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet ge0 and ge1 clocks
  ARM: kirkwood: Remove redundant ethernet clock enable

 arch/arm/mach-kirkwood/board-dt.c | 50 ---------------------------------------
 drivers/clk/mvebu/kirkwood.c      |  9 +++++--
 2 files changed, 7 insertions(+), 52 deletions(-)

-- 
1.8.1.5
