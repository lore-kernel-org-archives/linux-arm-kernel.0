From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Sat,  1 Jul 2017 10:02:45 +0800
Subject: [PATCH 3/5] ARM: dts: rockchip: enable ARM Mali GPU on rk3288-fennec
In-Reply-To: <1498874567-11219-1-git-send-email-jacob-chen@iotwrt.com>
References: <1498874567-11219-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1498874567-11219-4-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reference to the Mali GPU device tree node on rk3288-fennec
Tested on Fennec board.

Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 arch/arm/boot/dts/rk3288-fennec.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-fennec.dts b/arch/arm/boot/dts/rk3288-fennec.dts
index 61d1c10..9ece328 100644
--- a/arch/arm/boot/dts/rk3288-fennec.dts
+++ b/arch/arm/boot/dts/rk3288-fennec.dts
@@ -99,6 +99,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
 &hdmi {
 	status = "okay";
 };
-- 
2.7.4
