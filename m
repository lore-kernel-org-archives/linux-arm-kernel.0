From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 30 Apr 2015 14:30:51 +0100
Subject: [PATCH v3 5/6] ARM: DT: STi: STiH418: Add miphy28lp optional
 oscillator clock properties
In-Reply-To: <1430400652-3366-1-git-send-email-peter.griffin@linaro.org>
References: <1430400652-3366-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1430400652-3366-6-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STiH418 miphy28lp port0/1 need the oscillator clock configured in the same way
as on STiH407/STiH410 platforms.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih418-b2199.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index 926235c..e0e5b23 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -74,5 +74,16 @@
 			st,i2c-min-scl-pulse-width-us = <0>;
 			st,i2c-min-sda-pulse-width-us = <5>;
 		};
+
+		miphy28lp_phy: miphy28lp at 9b22000 {
+
+			phy_port0: port at 9b22000 {
+				st,osc-rdy;
+			};
+
+			phy_port1: port at 9b2a000 {
+				st,osc-force-ext;
+			};
+		};
 	};
 };
-- 
1.9.1
