From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 19 Jan 2018 14:39:30 +0100
Subject: [PATCH v2] arm64: dts: salvator-common: Enable HS400 of SDHI2
Message-ID: <20180119133930.11410-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds the mmc-hs400-1_8v property to SDHI2 and enable eMMC
HS400.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on renesas-devel-20180119-v4.15-rc8

Dependencies for testing and applying this patch upstream:
* [PATCH v2 0/3] mmc: renesas_sdhi: add eMMC HS400 mode support
* [PATCH] clk: renesas: rcar-gen3: Fix SD divider setting

To assist testing and review this patch and the above mentioned
dependencies, which are necessary and sufficient to enable HS400 on H3 /
Salvator-X, M3-W 1.0 / Salvator-X and H3 ES2.0 Salvator-XS are available
at:

https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/hs400-v2

v2 [Simon Horman]
* Broke out of larger patchset

v1 [Simon Horman]
* Rebase

v0 [Takeshi Kihara]


---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 89cbb3b95acd..34847c3653b8 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -631,6 +631,7 @@
 	vqmmc-supply = <&reg_1p8v>;
 	bus-width = <8>;
 	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
 	non-removable;
 	fixed-emmc-driver-type = <1>;
 	status = "okay";
-- 
2.11.0
