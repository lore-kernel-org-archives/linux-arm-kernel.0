From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Mar 2015 10:18:39 +0100
Subject: [PATCH v9]: clk: Add common clock support for Mediatek MT8135 and
 MT8173
Message-ID: <1427447925-18030-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the initial common clock support for Mediatek SoCs.
Mediatek SoC's clock architecture comprises of various PLLs, dividers, muxes
and clock gates.

Changes in v9:
- rename 'lock' to 'mt81xx_clk_lock' to get better lockdep output

Changes in v8:
- add patch to allow to put parent_name arrays in __initconst
- put parent_name arrays into __initconst

Changes in v7:
- fix duplicate definition/declaration of mtk_register_reset_controller
- fix pd_reg offset of tvdpll
- make clk initialization arrays const

Changes in v6:
- rework PLL support, only a fraction of original size now
- Move binding docs to Documentation/devicetree/bindings/arm/mediatek since
  the units are not really clock specific (they contain reset controllers)

Changes in v5:
- Add reset controller support for pericfg/infracfg
- Use regmap for the gates
- remove now unnecessary spinlock for the gates
- Add PMIC wrapper support as of v3

Changes in v4:
- Support MT8173 platform.
- Re-ordered patchset. driver/clk/Makefile in 2nd patch.
- Extract the common part definition(mtk_gate/mtk_pll/mtk_mux) from
  clk-mt8135.c/clk-mt8173.c to clk-mtk.c.
- Refine code. Rmove unnessacary debug information and unsed defines,
  add prefix "mtk_" for static functions.
- Remove flag CLK_IGNORE_UNUSED and set flag CLK_SET_RATE_PARENT on
  gate/mux/fixed-factor.
- Use spin_lock_irqsave(&clk_ops_lock, flags) instead of mtk_clk_lock.
- Example above include a node for the clock controller itself, followed
  by the i2c controller example above.

Changes in v3:
- Rebase to 3.19-rc1.
- Refine code. Remove unneed functions, debug logs and comments, and fine tune
  error logs.

Changes in v2:
- Re-ordered patchset. Fold include/dt-bindings and DT document in 1st patch.

Sascha
