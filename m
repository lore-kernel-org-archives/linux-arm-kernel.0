From: eric@anholt.net (Eric Anholt)
Date: Mon,  4 Apr 2016 20:20:54 -0700
Subject: [PATCH 0/2] minor bcm2835 clock fixes
Message-ID: <1459826456-18812-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are two little fixes for clk-bcm2835 from working on the arm64
port.

I'm fine with both of them landing in -next.  The PLL poweron is a
bugfix even for non-arm64, but I haven't seen it get hit before (I
needed to fail to include the pinctrl driver in order for the code
path to trigger).

Eric Anholt (2):
  clk: bcm2835: Fix compiler warnings on 64-bit builds
  clk: bcm2835: Fix PLL poweron

 drivers/clk/bcm/clk-bcm2835.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.7.0
