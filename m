From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 28 Mar 2013 13:59:00 -0700
Subject: [PATCH v6 0/2] reentrancy in the common clk framework
In-Reply-To: <1364445958-2999-1-git-send-email-mturquette@linaro.org>
References: <1364445958-2999-1-git-send-email-mturquette@linaro.org>
Message-ID: <1364504343-12635-1-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This sixth version of the series fixes up two minor cosmetic issues and
adds reviewed-by's and tested-by's.  If there are no more comments to
this version then I'll merge these patches into clk-next so that it can
get some cycles in linux-next.

Changes tested on top of the latest clk-next branch with an OMAP4430
Panda board.

Mike Turquette (2):
  clk: abstract locking out into helper functions
  clk: allow reentrant calls into the clk framework

 drivers/clk/clk.c |  139 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 101 insertions(+), 38 deletions(-)

-- 
1.7.10.4
