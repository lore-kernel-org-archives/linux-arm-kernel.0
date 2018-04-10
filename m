From: marcin@ziemianowicz.com (Marcin Ziemianowicz)
Date: Mon, 9 Apr 2018 20:15:51 -0400
Subject: [PATCH v2 0/2] clk: at91: Added more information logging
Message-ID: <20180410001551.GA62208@hak8or>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a series of patches which resolves set_rate() for the PLL not
having any effect and therefore the USB Host port not working. Also, a
few messages were added which may be helpful in the future when others
are working with USB clocking.

Changes since V1:
  Added patch set cover letter
  Shortened lines which were over >80 characters long
  > Comment by Greg Kroah-Hartman about "from" field in email addressed
  > Comment by Alan Stern about redundant debug lines addressed

hak8or (2):
  clk: at91: Added more information logging.
  clk: at91: Fix for PLL set_rate changes not being actually written to
    PLL peripheral bits

 drivers/clk/at91/clk-pll.c   | 14 +++++++++++++-
 drivers/clk/at91/clk-usb.c   | 10 ++++++++--
 drivers/usb/host/ohci-at91.c | 16 ++++++++++------
 3 files changed, 31 insertions(+), 9 deletions(-)

-- 
2.17.0
