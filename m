From: eric@anholt.net (Eric Anholt)
Date: Mon,  9 May 2016 18:01:27 -0700
Subject: [PATCH 0/3] clk: bcm2835: critical clocks and parent selection
Message-ID: <1462842090-2017-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the new patch 2 inserted between my previous pair, I think this
should cover Martin's bugs with clock disabling.

I tested patch 2 to be important on the downstream kernel: with the
DPI panel support added there, I was losing ethernet (my only I/O)
when the HDMI HSM hanging off of PLLD_PER got disabled due to
EPROBE_DEFER.

Eric Anholt (3):
  clk: bcm2835: Mark the VPU clock as critical
  clk: bcm2835: Mark GPIO clocks enabled at boot as critical.
  clk: bcm2835: Skip PLLC clocks when deciding on a new clock parent

 drivers/clk/bcm/clk-bcm2835.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

-- 
2.8.0.rc3
