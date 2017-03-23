From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Thu, 23 Mar 2017 12:53:17 +0800
Subject: [PATCH v2 0/8] soc: imx: gpc: fixes and clean up
Message-ID: <1490244805-3921-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series mostly fixes a few exist issues and clean up.
1) fix clk error handling to avoid kernel crash
2) fix wrong use of regmap cache
3) fix domain_index sanity check
4) fix mx6sl regression
5) a few clean up

Patch based on shawn/for-next tree.

Change Log:
v1->v2:
 * Only patch 4 changed for adding back the
   three domains support for MX6SL.
 * Added Lucas' Tags

Dong Aisheng (8):
  soc: imx: gpc: fix gpc clk get error handling
  soc: imx: gpc: fix the wrong using of regmap cache
  soc: imx: gpc: fix domain_index sanity check issue
  soc: imx: gpc: fix imx6sl gpc power domain regression
  soc: imx: gpc: fix comment when power up domain
  soc: imx: gpc: keep PGC_X_CTRL name align with reference manual
  dt-bindings: imx-gpc: correct the DOMAIN_INDEX using
  soc: imx: gpc: remove unnecessary readable_reg callback

 .../devicetree/bindings/power/fsl,imx-gpc.txt      |  4 +-
 drivers/soc/imx/gpc.c                              | 48 ++++++----------------
 2 files changed, 15 insertions(+), 37 deletions(-)

-- 
2.7.4
