From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 26 May 2015 14:42:57 +0200
Subject: [PATCH v2] clk: mvebu: add missing CESA gate clk
Message-ID: <1432644177-16152-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even if not documented in the datasheet, the Armada 370 SoC can actually
gate the CESA (crypto engine) clock.
Add an entry in the gating_desc table to be able to reference the CESA
gateclk in the crypto node.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Hi,

Sorry for the noise, but since the changes in this patch are quite
straightforward, I'm directly sending a v2 addressing Gregory's comments
(instead of waiting for more reviews).

Best Regards,

Boris

Changes since v1:
 - update the DT bindings doc
 - change the clock name to be consistent with other SoCs

 Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt | 1 +
 drivers/clk/mvebu/armada-370.c                                | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
index 31c7c0c..660e649 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
@@ -19,6 +19,7 @@ ID	Clock	Peripheral
 9	pex1	PCIe Cntrl 1
 15	sata0	SATA Host 0
 17	sdio	SDHCI Host
+23	crypto	CESA (crypto engine)
 25	tdm	Time Division Mplx
 28	ddr	DDR Cntrl
 30	sata1	SATA Host 0
diff --git a/drivers/clk/mvebu/armada-370.c b/drivers/clk/mvebu/armada-370.c
index 756f0f3..c19fd77 100644
--- a/drivers/clk/mvebu/armada-370.c
+++ b/drivers/clk/mvebu/armada-370.c
@@ -163,6 +163,7 @@ static const struct clk_gating_soc_desc a370_gating_desc[] __initconst = {
 	{ "pex1", "pex1_en", 9, 0 },
 	{ "sata0", NULL, 15, 0 },
 	{ "sdio", NULL, 17, 0 },
+	{ "crypto", NULL, 23, 0 },
 	{ "tdm", NULL, 25, 0 },
 	{ "ddr", NULL, 28, CLK_IGNORE_UNUSED },
 	{ "sata1", NULL, 30, 0 },
-- 
1.9.1
