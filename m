From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu,  3 May 2018 14:30:50 +0200
Subject: [PATCH v3 2/3] arm64: dts: renesas: salvator-common: Add PMIC DDR
 Backup Power config
In-Reply-To: <1525350651-12471-1-git-send-email-geert+renesas@glider.be>
References: <1525350651-12471-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1525350651-12471-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Salvator-X(S), all of the DDR0, DDR1, DDR0C, and DDR1C power rails
need to be kept powered when backup mode is enabled.  Reflect this in
the "rohm,ddr-backup-power" property for the BD9571MWV PMIC node.

The accessory power switch (SW23) is a toggle switch, hense specify
"rohm,rstbmode-level".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Use a hex value for the bit mask,

v2:
  - Add rohm,rstbmode-level.
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 2a7f36abd2dd85c6..0292c5072ef7a2fe 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -376,6 +376,8 @@
 		#interrupt-cells = <2>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		rohm,ddr-backup-power = <0xf>;
+		rohm,rstbmode-level;
 
 		regulators {
 			dvfs: dvfs {
-- 
2.7.4
