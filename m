From: sjg@chromium.org (Simon Glass)
Date: Fri,  3 Feb 2012 08:56:11 -0800
Subject: [PATCH 2/3] arm: tegra: dts: Add legacy mode support to Tegra2x USB1
 port
In-Reply-To: <1328288172-8059-1-git-send-email-sjg@chromium.org>
References: <1328288172-8059-1-git-send-email-sjg@chromium.org>
Message-ID: <1328288172-8059-3-git-send-email-sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra's USB1 port supports legacy mode, so mark it as such. Even if we
don't use it, we must turn it off in the driver.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/boot/dts/tegra20.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index ec1f010..a322c11 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -184,6 +184,7 @@
 		reg = <0xc5000000 0x4000>;
 		interrupts = < 0 20 0x04 >;
 		phy_type = "utmi";
+		nvidia,has-legacy-mode;
 	};
 
 	usb at c5004000 {
-- 
1.7.7.3
