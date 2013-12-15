From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Sun, 15 Dec 2013 19:30:50 +0100
Subject: [PATCH 0/2] pinctrl: at91: fix clk handling in suspend/resume funcs
Message-ID: <1387132252-2584-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series replaces clk_prepare + clk_enable or
clk_disable + clk_unprepare calls by single clk_prepapre_enable and
clk_disable_unprepare calls.

It also fixes the clk disable + unprepare order in the suspend function of the
pinctrl driver (unprepare must be called after disable).

Best Regards,

Boris

Boris BREZILLON (2):
  pinctrl: at91: fix clk_unprepare and clk_disable order
  pinctrl: at91: replace clk_prepare + clk_enable by clk_prepare_enable

 drivers/pinctrl/pinctrl-at91.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

-- 
1.7.9.5
