From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 5 Jun 2013 18:06:34 +0300
Subject: [PATCH 0/2] Fix some uses of clk->rate
Message-ID: <1370444796-18648-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using clk->rate directly does not take the CLK_GET_RATE_NOCACHE flag into
account. This can cause wrong results if the flag is set.

Peter De Schrijver (2):
  clk: use clk_get_rate() for debugfs
  clk: honor CLK_GET_RATE_NOCACHE in clk_set_rate

 drivers/clk/clk.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.7.7.rc0.72.g4b5ea.dirty
