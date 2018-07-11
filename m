From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 11 Jul 2018 15:11:15 +0300
Subject: [PATCH v3 0/2] Fix imx6sl display power domain
Message-ID: <cover.1531310547.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v2:
 * Don't mistakenly include IMX6SL_CLK_IPG in pd_disp
 * Use GENPD_FLAG_ALWAYS_ON, as suggested by Ulf

Errata workaround could be refined later, however the power savings are
small and it would require a lot of testing. So push the safest fix
first to get basic hardware support.

Link to v2: https://lkml.org/lkml/2018/7/9/447

Leonard Crestez (2):
  soc: imx: gpc: Disable 6sl display power gating for ERR006287
  ARM: dts: imx6sl: Convert gpc to new bindings

 arch/arm/boot/dts/imx6sl.dtsi | 35 +++++++++++++++++++++++++++++++----
 drivers/soc/imx/gpc.c         | 10 ++++++++++
 2 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.17.1
