From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Dec 2012 15:33:56 +0100
Subject: [PATCH 11/18] arm: kirkwood: add Device Tree informations for the
 SDIO controller
In-Reply-To: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1355841243-3254-12-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the SDIO controller has a Device Tree binding, let's use it
in kirkwood.dtsi.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 7735cee..baf1045 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -190,5 +190,13 @@
 			clocks = <&gate_clk 17>;
 			status = "okay";
 		};
+
+		mvsdio at 90000 {
+			compatible = "marvell,orion-sdio";
+			reg = <0x90000 0x200>;
+			interrupts = <28>;
+			clocks = <&gate_clk 4>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.9.5
