From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 25 Jan 2013 12:40:54 +0100
Subject: [PATCH 0/3] Fixup issues for clk_set_parent
Message-ID: <1359114057-11681-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Issues with racing for fetching spinlocks is present in the
clk_set_parent API. This patchset is trying to fixup these issues.

In short, while updating the clock tree toplogy the spinlock must be held
to prevent enable_count from being messed up.

Patch 1 and 2 prepares for patch 3, which is where the real issue are
resolved.

Ulf Hansson (3):
  clk: Remove _clk_reparent from API and restructure code
  clk: Improve errorhandling for clk_set_parent
  clk: Fixup locking issues for clk_set_parent

 drivers/clk/clk.c            |  192 +++++++++++++++++++++++++++---------------
 include/linux/clk-provider.h |    1 -
 2 files changed, 125 insertions(+), 68 deletions(-)

-- 
1.7.10
