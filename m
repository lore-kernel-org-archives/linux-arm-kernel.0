From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  3 Jul 2014 16:14:39 +0200
Subject: [PATCH 05/18] AT91: SAMA5D3: DT: Add shutdown controller
In-Reply-To: <1404396906-25194-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1404396906-25194-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1404396906-25194-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SAMA5D3 has a shutdown controller identical to the sam9x5 SoC family.
Declare it in the DT.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index e0b15a6e8897..8bcf1c442c96 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1178,6 +1178,11 @@
 				reg = <0xfffffe00 0x10>;
 			};
 
+			shutdown-controller at fffffe10 {
+				compatible = "atmel,at91sam9x5-shdwc";
+				reg = <0xfffffe10 0x10>;
+			};
+
 			pit: timer at fffffe30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffe30 0xf>;
-- 
2.0.1
