From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 27 Nov 2013 13:44:43 +0100
Subject: [PATCH v2 0/2] clk: add clk accuracy support
Message-ID: <1385556285-19180-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds support for clock accuracy retrieval in the common clk
framework.

Best Regards,

Boris

Changes since v1:
 - remove HAVE_CLK_GET_ACCURACY option and enable clk accuracy support only
   when using the CCF
 - export __clk_get_accuracy (might be used by clk-providers)
 - fix documentation (s/recalc_rate/recalc_accuracy/)
 - move fixed_accuracy field addition (struct clk_fixed_rate) from the 1st
   patch to the 2nd patch of this series

Boris BREZILLON (2):
  clk: add clk accuracy retrieval support
  clk: add accuracy support for fixed clock

 Documentation/clk.txt                              |    4 +
 .../devicetree/bindings/clock/fixed-clock.txt      |    3 +
 drivers/clk/clk-fixed-rate.c                       |   43 ++++++--
 drivers/clk/clk.c                                  |  109 +++++++++++++++++++-
 include/linux/clk-private.h                        |    1 +
 include/linux/clk-provider.h                       |   15 +++
 include/linux/clk.h                                |   17 +++
 7 files changed, 182 insertions(+), 10 deletions(-)

-- 
1.7.9.5
