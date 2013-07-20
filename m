From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 20 Jul 2013 11:17:55 +0400
Subject: [PATCH 2/6] ARM: dts: i.MX27: Remove optional "ptp" clock source for
 FEC
In-Reply-To: <1374304679-27338-1-git-send-email-shc_work@mail.ru>
References: <1374304679-27338-1-git-send-email-shc_work@mail.ru>
Message-ID: <1374304679-27338-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch removes optional "ptp" clock source for FEC. This clock is
missing in i.MX27.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index e9d60ab..7cf954b 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -428,8 +428,8 @@
 				compatible = "fsl,imx27-fec";
 				reg = <0x1002b000 0x4000>;
 				interrupts = <50>;
-				clocks = <&clks 48>, <&clks 67>, <&clks 0>;
-				clock-names = "ipg", "ahb", "ptp";
+				clocks = <&clks 48>, <&clks 67>;
+				clock-names = "ipg", "ahb";
 				status = "disabled";
 			};
 		};
-- 
1.8.1.5
