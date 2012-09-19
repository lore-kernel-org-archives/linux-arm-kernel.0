From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Sep 2012 23:05:27 -0700
Subject: [PATCH 0/3] Introduce devm_clk_register()
Message-ID: <1348034730-16473-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch in this series fixes error checking in the wm831x clock
driver and is here to prevent context conflicts in the third patch.
I split it out in case it needed to merge sooner rather than later.

The goal of this series is to add devm_clk_register() so I can use it in
some MSM clock code I'm sending out in the near future. The second 
patch adds the API and the third patch moves over an existing user of
clk_unregister() to the devm API.

Stephen Boyd (3):
  clk: wm831x: Fix clk_register() error code checking
  clk: Add devm_clk_{register,unregister}()
  clk: wm831x: Use devm_clk_register() to simplify code

 drivers/clk/clk-wm831x.c     |  34 ++++---------
 drivers/clk/clk.c            | 111 +++++++++++++++++++++++++++++++++++--------
 include/linux/clk-provider.h |   2 +
 3 files changed, 101 insertions(+), 46 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
