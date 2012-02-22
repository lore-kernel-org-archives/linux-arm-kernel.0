From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 22 Feb 2012 19:18:46 +0000
Subject: [PATCH 3/3] arm: kirkwood: convert uart0 to devicetree.
In-Reply-To: <cover.1329936660.git.jason@lakedaemon.net>
References: <cover.1329936660.git.jason@lakedaemon.net>
Message-ID: <0ad28cac6d608253b01e1d57bb479a29754ae823.1329936660.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This uart is common to all kirkwood SoC's, so I placed it in the
kirkwood.dtsi.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
NOTE: first version of this patch, no changelog.

 arch/arm/boot/dts/kirkwood.dtsi   |    8 ++++++++
 arch/arm/mach-kirkwood/board-dt.c |    2 --
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 771c6bb..0531dbb 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -2,5 +2,13 @@
 
 / {
 	compatible = "marvell,kirkwood";
+
+	serial at f1012000 {
+		compatible = "ns16550a";
+		reg = <0xf1012000 0xff>;
+		reg-shift = <2>;
+		interrupts = <33>;
+		clock-frequency = <200000000>;
+	};
 };
 
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index ab13eb9..e247ca7 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -140,8 +140,6 @@ static void __init dreamplug_init(void)
 	 */
 	kirkwood_mpp_conf(dreamplug_mpp_config);
 
-	kirkwood_uart0_init();
-
 	spi_register_board_info(dreamplug_spi_slave_info,
 				ARRAY_SIZE(dreamplug_spi_slave_info));
 	kirkwood_spi_init();
-- 
1.7.3.4
