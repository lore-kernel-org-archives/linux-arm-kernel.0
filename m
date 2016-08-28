From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 28 Aug 2016 19:32:46 +0200
Subject: [PATCH 4/4] ARM: tegra: nyan-blaze: Include compatible revisions for
 proper detection
In-Reply-To: <20160828173246.32621-1-contact@paulk.fr>
References: <20160828173246.32621-1-contact@paulk.fr>
Message-ID: <20160828173246.32621-4-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depthcharge (the payload used with cros devices) will attempt to detect
boards using their revision. This includes all the known revisions for
the nyan-blaze board so that the dtb can be selected preferably.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/tegra124-nyan-blaze.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan-blaze.dts b/arch/arm/boot/dts/tegra124-nyan-blaze.dts
index c9582361..aca0828 100644
--- a/arch/arm/boot/dts/tegra124-nyan-blaze.dts
+++ b/arch/arm/boot/dts/tegra124-nyan-blaze.dts
@@ -6,7 +6,13 @@
 
 / {
 	model = "HP Chromebook 14";
-	compatible = "google,nyan-blaze", "google,nyan", "nvidia,tegra124";
+	compatible = "google,nyan-blaze-rev10", "google,nyan-blaze-rev9",
+			"google,nyan-blaze-rev8", "google,nyan-blaze-rev7",
+			"google,nyan-blaze-rev6", "google,nyan-blaze-rev5",
+			"google,nyan-blaze-rev4", "google,nyan-blaze-rev3",
+			"google,nyan-blaze-rev2", "google,nyan-blaze-rev1",
+			"google,nyan-blaze-rev0", "google,nyan-blaze",
+			"google,nyan", "nvidia,tegra124";
 
 	panel: panel {
 		compatible = "samsung,ltn140at29-301";
-- 
2.9.3
