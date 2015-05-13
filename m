From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 13 May 2015 16:06:59 +0930
Subject: [PATCHv5 4/5] ARM: dts: exynos5420 update the cooling cells for core
 cpu0
In-Reply-To: <1431499020-3912-1-git-send-email-linux.amoon@gmail.com>
References: <1431499020-3912-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1431499020-3912-5-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

update the cooling level for cpu0 to avoid following message.

root at odroidxu3:~# dmesg | grep ther
[    0.241511] /thermal-zones/cpu-thermal/cooling-maps/map0:
                         could not get #cooling-cells for /cpus/cpu at 0

Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Acked-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 4531753..c75ed16 100644
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
