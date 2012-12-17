From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 17 Dec 2012 13:02:11 -0800
Subject: [PATCH 0/4] Introduce of_init_clk_data() for DT clock parsing
Message-ID: <1355778135-32458-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I see the same pattern repeated a few times to parse the common clock
bindings for a particular clock. Instead of wrting this code another
time, let's consolidate the logic in one place and standardize how
clocks will be named from their bindings.

After this series there are no more users of of_clk_get_parent_name()
so we may want to delete it.

Stephen Boyd (4):
  clk: Add of_init_clk_data() to parse common clock bindings
  clk: highbank: Use of_init_clk_data()
  clk: vt8500: Use of_init_clk_data()
  clk: zynq: Use of_init_clk_data()

 drivers/clk/clk-highbank.c   | 21 ++++++----------
 drivers/clk/clk-vt8500.c     | 39 ++++++++++++-----------------
 drivers/clk/clk-zynq.c       | 28 +++++++--------------
 drivers/clk/clk.c            | 58 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/clk-provider.h |  2 ++
 5 files changed, 91 insertions(+), 57 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
