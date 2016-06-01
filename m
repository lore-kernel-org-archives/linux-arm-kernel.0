From: eric@anholt.net (Eric Anholt)
Date: Wed,  1 Jun 2016 12:05:32 -0700
Subject: [PATCH v3 0/4] clk: bcm2835: critical clocks and parent selection
Message-ID: <1464807936-532-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I figured out another critical clock (patch 3), but didn't use the
CLK_IS_CRITICAL flag since I want to just protect whatever clock
happens to be the parent (there are #ifdefs in the firmware indicating
that they've experimented with using different clocks as the parent).

I think these fixes are all suitable for 4.7.

Eric Anholt (4):
  clk: bcm2835: Mark the VPU clock as critical
  clk: bcm2835: Mark GPIO clocks enabled at boot as critical
  clk: bcm2835: Mark the CM SDRAM clock's parent as critical
  clk: bcm2835: Skip PLLC clocks when deciding on a new clock parent

 drivers/clk/bcm/clk-bcm2835.c | 63 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

-- 
2.8.0.rc3
