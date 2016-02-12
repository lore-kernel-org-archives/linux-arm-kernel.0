From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 12 Feb 2016 15:11:50 +0000
Subject: [PATCH 0/3] clk: sunxi: error checking on clock setup
Message-ID: <1455289913-29514-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since I promised to do this some days ago:

Setting up the clocks properly is quite critical to the system's
operation, but currently our error handling is not very verbose.
This series adds error handling and reporting to the sunxi clocks,
so that any errors are correctly detected and reported. Also previous
actions are rolled back in case something went wrong.
This proves to be helpful in debugging clock tree issues,
especially when adding support for new SoCs.
I tested this on a BananaPi by deliberately misspelling
"clock-output-names". The resulting kernel crash in
sun4i_timer_interrupt is totally misleading, but now there is a line
in the dmesg before saying:
=======
sunxi_divider_clk_setup: could not read clock-output-names for "apb0"
=======

This applies on top of Maxime's sunxi/for-next branch.

Please have a look (and apply, if you like it).

Cheers,
Andre.

Andre Przywara (3):
  clk: sunxi: improve mux_clk error handling and reporting
  clk: sunxi: improve divider_clk error handling and reporting
  clk: sunxi: Improve divs_clk error handling and reporting

 drivers/clk/sunxi/clk-sunxi.c | 68 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 12 deletions(-)

-- 
2.6.4
