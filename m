From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 20 Jul 2017 12:22:46 +0200
Subject: [PATCH 3/4] arm64: dts: mediatek: add watchdog to MT6796
In-Reply-To: <20170720102247.12342-1-matthias.bgg@gmail.com>
References: <20170720102247.12342-1-matthias.bgg@gmail.com>
Message-ID: <20170720102247.12342-3-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <mbrugger@suse.com>

This patch adds the watchdog driver to the MT6796 SoC.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt6797.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 31088a9f71de..1cb45219ef05 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -147,6 +147,11 @@
 		infracfg = <&infrasys>;
 	};
 
+	watchdog: watchdog at 10007000 {
+		compatible = "mediatek,mt6797-wdt", "mediatek,mt6589-wdt";
+		reg = <0 0x10007000 0 0x100>;
+	};
+
 	apmixedsys: apmixed at 1000c000 {
 		compatible = "mediatek,mt6797-apmixedsys";
 		reg = <0 0x1000c000 0 0x1000>;
-- 
2.12.3
