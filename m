From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 28 Aug 2016 19:32:45 +0200
Subject: [PATCH 3/4] ARM: tegra: nyan-big: Include compatible revisions for
 proper detection
In-Reply-To: <20160828173246.32621-1-contact@paulk.fr>
References: <20160828173246.32621-1-contact@paulk.fr>
Message-ID: <20160828173246.32621-3-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depthcharge (the payload used with cros devices) will attempt to detect
boards using their revision. This includes all the known revisions for
the nyan-big board so that the dtb can be selected preferably.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/tegra124-nyan-big.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts b/arch/arm/boot/dts/tegra124-nyan-big.dts
index 67d7cfb..f12ece9 100644
--- a/arch/arm/boot/dts/tegra124-nyan-big.dts
+++ b/arch/arm/boot/dts/tegra124-nyan-big.dts
@@ -6,7 +6,12 @@
 
 / {
 	model = "Acer Chromebook 13 CB5-311";
-	compatible = "google,nyan-big", "nvidia,tegra124";
+	compatible = "google,nyan-big-rev7", "google,nyan-big-rev6",
+			"google,nyan-big-rev5", "google,nyan-big-rev4",
+			"google,nyan-big-rev3", "google,nyan-big-rev2",
+			"google,nyan-big-rev5", "google,nyan-big-rev4",
+			"google,nyan-big-rev1", "google,nyan-big-rev0",
+			"google,nyan-big", "google,nyan", "nvidia,tegra124";
 
 	panel: panel {
 		compatible = "auo,b133xtn01";
-- 
2.9.3
