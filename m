From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 12 Jan 2016 14:59:13 +0100
Subject: [PATCH] ARM: sunxi: Add CPU regulator for cpufreq
Message-ID: <1452607153-8698-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current DT doesn't have a phandle to the CPU regulator in the CPU node,
which disables the CPU voltage scaling entirely.

Add that phandle.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-r8-chip.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index 530ab28e9ca2..f6898c6b84d4 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -70,6 +70,10 @@
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.6.4
