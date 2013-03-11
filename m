From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 12 Mar 2013 00:42:09 +0100
Subject: [PATCH 0/4] clk: samsung: small fixes and enhancements
Message-ID: <201303120042.09633.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Small fixes and enhancements that came up when implementing the
common clock support for s3c2443, s3c2416 and s3c2450.

The 3rd and 4th patch enable the adding of separate aliases
to previously defined clocks, as discussed with Sylwester Nawrocki.

This is often needed as some clocks need more than one alias. The hsmmc
hclks on s3c2416 for example are both "hsmmc" and "mmc_busclk.0" .

These changes are required for the common clock conversion of s3c24xx SoCs.

Heiko Stuebner (4):
  clk: samsung: register clk_div_tables for divider clocks
  clk: samsung: remove np check in clock init
  clk: samsung: always allocate the clk_table
  clk: samsung: add infrastructure to add separate aliases

 drivers/clk/samsung/clk.c |   51 +++++++++++++++++++++++++++++++++++++++-----
 drivers/clk/samsung/clk.h |   34 ++++++++++++++++++++++++++---
 2 files changed, 75 insertions(+), 10 deletions(-)

-- 
1.7.2.3
