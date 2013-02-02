From: girishks2000@gmail.com (girishks2000 at gmail.com)
Date: Fri,  1 Feb 2013 17:56:25 -0800
Subject: [PATCH 2/2] arm: exynos5440: add dts node for the ahci sata
In-Reply-To: <1359770185-31867-1-git-send-email-yes>
References: <1359770185-31867-1-git-send-email-yes>
Message-ID: <510c7283.a4d1440a.7061.2699@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Girish K S <ks.giri@samsung.com>

This patch adds dts support for the sata controller

Signed-off-by: Girish K S <ks.giri@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index a00ed6a..8d6a784 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -193,4 +193,13 @@
 		clocks = <&clock 8>;
 		clock-names = "rtc";
 	};
+
+	sata at 210000 {
+		compatible = "samsung,exynos5440-ahci";
+		reg = <0x210000 0x10000>;
+		interrupts = <0 30 0>;
+		clocks = <&clock 10>;
+		clock-names = "sata";
+	};
+
 };
-- 
1.7.10.4
