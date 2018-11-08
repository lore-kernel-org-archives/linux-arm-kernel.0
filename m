From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu,  8 Nov 2018 14:53:49 +0100
Subject: [PATCH 1/4] arm64: dts: meson-axg: fix mailbox address
In-Reply-To: <20181108135352.8459-1-jbrunet@baylibre.com>
References: <20181108135352.8459-1-jbrunet@baylibre.com>
Message-ID: <20181108135352.8459-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MHU mailbox address is wrong. Fixing it enables the mailboxes on the A113.
These mailboxes are needed for SCPI

Fixes: 9d59b708500f ("arm64: dts: meson-axg: add initial A113D SoC DT support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 3cc0044d3468..ff8b3406aff6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1067,9 +1067,9 @@
 			};
 		};
 
-		mailbox: mailbox at ff63dc00 {
+		mailbox: mailbox at ff63c404 {
 			compatible = "amlogic,meson-gx-mhu", "amlogic,meson-gxbb-mhu";
-			reg = <0 0xff63dc00 0 0x400>;
+			reg = <0 0xff63c404 0 0x4c>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 210 IRQ_TYPE_EDGE_RISING>;
-- 
2.19.1
