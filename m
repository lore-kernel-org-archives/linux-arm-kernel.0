From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Thu, 27 Feb 2014 21:30:27 +0100
Subject: [PATCH v2 3/8] ARM: dts: omap3-overo: Use complete poweroff
In-Reply-To: <1393533032-1619-1-git-send-email-florian.vaussard@epfl.ch>
References: <1393533032-1619-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1393533032-1619-4-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the TWL4030 PMIC does not completely poweroff the processor.
Commit b0fc1da4d0359d3cce8f12e0f014aed0704ae202 introduced the necessary
binding to do this, so use it.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index aea64c0..018e1e0 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -73,6 +73,11 @@
 			codec {
 			};
 		};
+
+		twl_power: power {
+			compatible = "ti,twl4030-power";
+			ti,use_poweroff;
+		};
 	};
 };
 
-- 
1.8.5.3
