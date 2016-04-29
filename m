From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 29 Apr 2016 17:42:34 +0000
Subject: [PATCH V4 0/2] clk: bcm2835: use CLK_IS_CRITICAL/CLK_ENABLE_HAND_OFF
Message-ID: <1461951756-16804-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The bcm2835 firmware enables several clocks and plls before
booting the linux kernel, when these later are claimed by a driver
(temporarily) and then released, then the corresponding plls are
disabled, which result in a crashed system.

Ideally we want to use CLK_ENABLE_HAND_OFF to mark those already
enabled clocks, but as CLK_ENABLE_HAND_OFF is not merged
yet this patchset takes a 2 setp approach:
In the first patch it first makes use of the - already in
clk-next - CLK_IS_CRITICAL.
The second patch will change the use to CLK_ENABLE_HAND_OFF,
which can get applied when the HAND_OFF patch-set goes in.

Martin Sperl (2):
  clk: bcm2835: mark enabled clocks with CLK_IS_CRITICAL
  clk: bcm2835: use CLK_ENABLE_HAND_OFF instead of CLK_IS_CRITICAL

 drivers/clk/bcm/clk-bcm2835.c | 8 ++++++++
 1 file changed, 8 insertions(+)

--
2.1.4
