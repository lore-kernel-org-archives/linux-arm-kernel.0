From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 14 May 2014 17:33:04 -0700
Subject: [RFC PATCH 08/10] ARM: tegra124: Bind CAR to syscon device
In-Reply-To: <1400113986-339-1-git-send-email-abrestic@chromium.org>
References: <1400113986-339-1-git-send-email-abrestic@chromium.org>
Message-ID: <1400113986-339-9-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The XUSB PHY driver will be accessing the CAR registers through the
syscon interface.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/arm/boot/dts/tegra124.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 197e848..47fb61c 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -115,7 +115,7 @@
 	};
 
 	tegra_car: clock at 0,60006000 {
-		compatible = "nvidia,tegra124-car";
+		compatible = "nvidia,tegra124-car", "syscon";
 		reg = <0x0 0x60006000 0x0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
1.9.1.423.g4596e3a
