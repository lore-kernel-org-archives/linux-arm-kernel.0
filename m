From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 18 Apr 2014 16:29:41 -0700
Subject: [PATCH 0/2] Clock unregistration fixes
Message-ID: <1397863783-10728-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two fixes for fallout from commit fcb0ee6a3d33 (clk: Implement clk_unregister).

Stephen Boyd (2):
  clk: Fix double free due to devm_clk_register()
  clk: Fix slab corruption in clk_unregister()

 drivers/clk/clk.c | 74 ++++++++++++++++++++++++-------------------------------
 1 file changed, 32 insertions(+), 42 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
