From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 27 Mar 2013 21:45:56 -0700
Subject: [PATCH v5 0/2] reentrancy in the common clk framework
In-Reply-To: <1364368183-24420-1-git-send-email-mturquette@linaro.org>
References: <1364368183-24420-1-git-send-email-mturquette@linaro.org>
Message-ID: <1364445958-2999-1-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fifth attempt at allowing calls to the clk api to reenter splits
the last patch into two parts.  The first patch abstracts out the
locking details into some helper functions and converts all of the
direct calls to the mutex and spinlock api to use these helpers.

The second patch introduces the reentrancy logic into these helper
functions.  Fundamentally the reentrancy logic hasn't changed since v4,
but fixing casting bugs, removing unnecessary barriers and better design
& beautification separate this approach from the last one.

Changes tested on top of the latest clk-next branch with an OMAP4430
Panda board.

Mike Turquette (2):
  clk: abstract locking out into helper functions
  clk: allow reentrant calls into the clk framework

 drivers/clk/clk.c |  136 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 98 insertions(+), 38 deletions(-)

-- 
1.7.10.4
