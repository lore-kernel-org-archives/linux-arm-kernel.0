From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 16 Nov 2012 16:56:52 +0100
Subject: [PATCH 3/3] ARM: tegra: tec: Enable HDMI output
In-Reply-To: <1353081412-19448-1-git-send-email-thierry.reding@avionic-design.de>
References: <1353081412-19448-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1353081412-19448-4-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the HDMI output found on Tamonten Evaluation Carrier boards.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/arm/boot/dts/tegra20-tec.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-tec.dts b/arch/arm/boot/dts/tegra20-tec.dts
index 916bec1..402b210 100644
--- a/arch/arm/boot/dts/tegra20-tec.dts
+++ b/arch/arm/boot/dts/tegra20-tec.dts
@@ -6,6 +6,12 @@
 	model = "Avionic Design Tamonten Evaluation Carrier";
 	compatible = "ad,tec", "ad,tamonten", "nvidia,tegra20";
 
+	host1x {
+		hdmi {
+			status = "okay";
+		};
+	};
+
 	i2c at 7000c000 {
 		wm8903: wm8903 at 1a {
 			compatible = "wlf,wm8903";
-- 
1.8.0
