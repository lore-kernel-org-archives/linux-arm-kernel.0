From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 2 Apr 2013 23:09:36 +0200
Subject: [PATCH V4 0/3] clk: Fixup issues for clk_set_parent
Message-ID: <1364936979-20805-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

These issues exist in the clk_set_parent API:

* Race issue for spinlocks when updating the clock tree toplogy.
* The feature of reparent to the orphan list is broken.

This patchset fixes both problems. Patch 1 prepares for patch 2 and
patch 3, which are where the real issues are resolved.

Changes in v4:
	- Rebased on top Mike's clk reentrancy patches.

Changes in v3:
	- Fix review comments from Mike.
	- Include fixup for allow reparent to the orphan list.

Changes in v2:
	- Do not remove the existing __clk_reparent API.
	- Rebase patches.

Ulf Hansson (3):
  clk: Restructure code for __clk_reparent
  clk: Fixup errorhandling for clk_set_parent
  clk: Fixup locking issues for clk_set_parent

 drivers/clk/clk.c |  193 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 130 insertions(+), 63 deletions(-)

-- 
1.7.10
