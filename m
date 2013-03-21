From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 21 Mar 2013 14:48:10 +0100
Subject: [PATCH V2 0/3] clk: Fixup issues for clk_set_parent
Message-ID: <1363873693-30902-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Issues with racing for fetching spinlocks is present in the
clk_set_parent API. This patchset is trying to fixup these issues.

In short, while updating the clock tree toplogy the spinlock must be held
to prevent enable_count from being messed up.

Patch 1 and 2 prepares for patch 3, which is where the real issue are
resolved.

Changes in v2:
	- Do not remove the existing __clk_reparent API.
	- Rebase patches.

Ulf Hansson (3):
  clk: Restructure code for __clk_reparent
  clk: Improve errorhandling for clk_set_parent
  clk: Fixup locking issues for clk_set_parent

 drivers/clk/clk.c |  184 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 122 insertions(+), 62 deletions(-)

-- 
1.7.10
