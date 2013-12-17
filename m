From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Tue, 17 Dec 2013 15:36:21 +0100
Subject: [PATCH v3 0/2] clk: add clk accuracy support
Message-ID: <1387290983-6236-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds support for clock accuracy retrieval in the common clk
framework.

Best Regards,

Boris

Changes since v2:
 - fix __clk_recalc_accuracies function comment
 - modify __clk_get_accuracy to return the current clock accuracy even when the
   clock is orphan
 - only recalculate clock accuracy when reparent succeed

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
 drivers/clk/clk.c                                  |  103 ++++++++++++++++++--
 include/linux/clk-private.h                        |    1 +
 include/linux/clk-provider.h                       |   15 +++
 include/linux/clk.h                                |   17 ++++
 7 files changed, 173 insertions(+), 13 deletions(-)

-- 
1.7.9.5
