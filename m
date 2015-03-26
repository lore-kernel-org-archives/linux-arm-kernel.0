From: linux.amoon@gmail.com (Anand Moon)
Date: Fri, 27 Mar 2015 03:09:11 +1030
Subject: [PATCH 2/6] ARM: dts exynos5420 update the cooling cells for core cpu0
In-Reply-To: <1427387955-5129-1-git-send-email-linux.amoon@gmail.com>
References: <1427387955-5129-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1427387955-5129-3-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

update the cooling level for cpu0 to avoid following message.

root at odroidxu3:~# dmesg | grep ther
[    0.241511] /thermal-zones/cpu-thermal/cooling-maps/map0:
			 could not get #cooling-cells for /cpus/cpu at 0

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index c0e98cf..6b49f3c 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -61,6 +61,10 @@
 			reg = <0x0>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+
+			cooling-min-level = <10>;
+			cooling-max-level = <7>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu1: cpu at 1 {
-- 
1.9.1
