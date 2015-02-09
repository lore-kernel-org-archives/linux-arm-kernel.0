From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  9 Feb 2015 11:47:12 +0100
Subject: [PATCH v5]: clk: Add common clock support for Mediatek MT8135 and
 MT8173
Message-ID: <1423478845-2835-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the initial common clock support for Mediatek SoCs.
Mediatek SoC's clock architecture comprises of various PLLs, dividers, muxes and clock gates.

This patchset also contains a basic clock support for Mediatek MT8135 and MT8173.

Also included is now my PMIC wrapper series as of v3. Since it now depends on
the clock drivers I can no longer post it independenty.

This driver is based on 3.19-rc1 + MT8135 and MT8173 basic support.

Changes in v2:
- Re-ordered patchset. Fold include/dt-bindings and DT document in 1st patch.

Changes in v3:
- Rebase to 3.19-rc1.
- Refine code. Remove unneed functions, debug logs and comments, and fine tune error logs.

Changes in v4:
- Support MT8173 platform.
- Re-ordered patchset. driver/clk/Makefile in 2nd patch.
- Extract the common part definition(mtk_gate/mtk_pll/mtk_mux) from clk-mt8135.c/clk-mt8173.c to clk-mtk.c.
- Refine code. Rmove unnessacary debug information and unsed defines, add prefix "mtk_" for static functions.
- Remove flag CLK_IGNORE_UNUSED and set flag CLK_SET_RATE_PARENT on gate/mux/fixed-factor.
- Use spin_lock_irqsave(&clk_ops_lock, flags) instead of mtk_clk_lock.
- Example above include a node for the clock controller itself, followed by the i2c controller example above.

Changes in v5:
- Add reset controller support for pericfg/infracfg
- Use regmap for the gates
- remove now unnecessary spinlock for the gates
- Add PMIC wrapper support as of v3

Sascha
