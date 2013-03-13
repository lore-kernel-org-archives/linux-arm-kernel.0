From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Wed, 13 Mar 2013 14:58:18 +0100
Subject: [PATCH v2 0/4] clk: samsung: pm fixes and multiple aliases
Message-ID: <201303131458.18671.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Second version of the fixes to address comments gathered from the first
version, like not entering the dt code on non-dt platforms even if
dt-support is present in the kernel.

Patch 1 and 3 got "Reviewed-by" tags but I only included the one for
patch 1, because patch 3 changed due to the changes in patch 2.

Heiko Stuebner (4):
  clk: samsung: register clk_div_tables for divider clocks
  clk: samsung: fix pm init on non-dt platforms
  clk: samsung: always allocate the clk_table
  clk: samsung: add infrastructure to add separate aliases

 drivers/clk/samsung/clk.c |   72 +++++++++++++++++++++++++++++++++++---------
 drivers/clk/samsung/clk.h |   34 ++++++++++++++++++--
 2 files changed, 87 insertions(+), 19 deletions(-)

-- 
1.7.2.3
