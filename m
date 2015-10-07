From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 7 Oct 2015 17:14:41 +0800
Subject: [PATCH v2 3/3] arm64: dts: mt8173: Add clocks for SCPSYS unit
In-Reply-To: <1444209281-25536-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1444209281-25536-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1444209281-25536-4-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clocks needed by Mediatek VENC and VENC_LT power domianis.
These clocks were needed by accessing subsystem's registers,
so they need to be enabled before power on these subsystems.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 06a1564..30fb201 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -227,8 +227,10 @@
 			#power-domain-cells = <1>;
 			reg = <0 0x10006000 0 0x1000>;
 			clocks = <&clk26m>,
-				 <&topckgen CLK_TOP_MM_SEL>;
-			clock-names = "mfg", "mm";
+				 <&topckgen CLK_TOP_MM_SEL>,
+				 <&topckgen CLK_TOP_VENC_SEL>,
+				 <&topckgen CLK_TOP_VENC_LT_SEL>;
+			clock-names = "mfg", "mm", "venc", "venc_lt";
 			infracfg = <&infracfg>;
 		};
 
-- 
1.9.1
