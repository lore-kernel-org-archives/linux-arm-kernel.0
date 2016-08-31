From: clg@kaod.org (=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=)
Date: Wed, 31 Aug 2016 19:24:19 +0200
Subject: [PATCH 3/3] ARM: dts: aspeed: Enable BT IPMI host device
In-Reply-To: <1472664259-23933-1-git-send-email-clg@kaod.org>
References: <1472664259-23933-1-git-send-email-clg@kaod.org>
Message-ID: <1472664259-23933-4-git-send-email-clg@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 6 ++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 22dee5937d5c..1cf57a2b08d3 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -82,6 +82,12 @@
 				clocks = <&clk_apb>;
 			};
 
+			ibt: ibt at 1e789140 {
+				compatible = "aspeed,bt-host";
+				reg = <0x1e789140 0x18>;
+				interrupts = <8>;
+			};
+
 			wdt1: wdt at 1e785000 {
 				compatible = "aspeed,wdt";
 				reg = <0x1e785000 0x1c>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index dd94d9361fda..9f29c409d606 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -86,6 +86,12 @@
 				clocks = <&clk_apb>;
 			};
 
+			ibt: ibt at 1e789140 {
+				compatible = "aspeed,bt-host";
+				reg = <0x1e789140 0x18>;
+				interrupts = <8>;
+			};
+
 			wdt1: wdt at 1e785000 {
 				compatible = "aspeed,wdt";
 				reg = <0x1e785000 0x1c>;
-- 
2.7.4
