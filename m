From: jiada_wang@mentor.com (jiada_wang at mentor.com)
Date: Wed, 21 May 2014 07:47:49 -0700
Subject: [PATCH v2 0/2] i.MX PLLv3: powerdown PLL before changing of its
 setting
Message-ID: <1400683671-19132-1-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiada Wang <jiada_wang@mentor.com>

This patch powers down PLL before changing of its setting
in set_rate() interface, and restores power & bypass status
after the change.

v2:
* unset pllv3 BYPASS and POWER sequentially in unprepare
* add common __clk_pllv3_powerset() to set power & bypass status

v1:
* inital version

Dirk Behme (1):
  ARM: imx: unset pllv3 BYPASS and POWER sequentially

Jiada Wang (1):
  ARM: imx: powerdown PLL before changing of its setting

 arch/arm/mach-imx/clk-pllv3.c |   55 ++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 12 deletions(-)

-- 
1.7.9.5
