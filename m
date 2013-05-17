From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 18 May 2013 09:18:48 +1200
Subject: [PATCH 0/4] VT8500 clock for 3.10/3.11
Message-ID: <1368825532-30917-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Patch #1 is a fix for 3.10 please - Due to an unbalanced spinlock in
vt8500_dclk_set_rate() we get kernel dumps on bootup.

Patch #2 adds support for the PLL clocks on WM8850 - originally it was thought
these were the same as WM8750, but with the release of vendor source it's now
confirmed to be different.

Patch #3 removes a check (which is also done in vt8500_dclk_round_rate) to
ensure the divisor is correct. Due to rounding errors, this usually results in
a lower than requested clock rate. Because round_rate is always called on all
our clocks, this test is actually redundant so I have dropped it.

Patch #4 is to add clk-vt8500.c to MAINTAINERS

Regards
Tony Prisk

Tony Prisk (4):
  clk: vt8500: Fix unbalanced spinlock in vt8500_dclk_set_rate()
  clk: vt8500: Add support for clocks on the WM8850 SoCs
  clk: vt8500: Remove unnecessary divisor adjustment in
    vtwm_dclk_set_rate()
  MAINTAINERS: vt8500: Add clk-vt8500.c to MAINTAINERS file

 Documentation/devicetree/bindings/clock/vt8500.txt |    2 +
 MAINTAINERS                                        |    1 +
 drivers/clk/clk-vt8500.c                           |   77 ++++++++++++++++++--
 3 files changed, 75 insertions(+), 5 deletions(-)

-- 
1.7.9.5
