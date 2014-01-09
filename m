From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Thu,  9 Jan 2014 17:47:59 +0100
Subject: [PATCH 05/18] ARM: dts: omap3-overo: Use complete poweroff
In-Reply-To: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
References: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1389286092-27087-6-git-send-email-florian.vaussard@epfl.ch>
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
index 2d8b80c..d48f25c 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -76,6 +76,11 @@
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
1.8.1.2
