From: girishks2000@gmail.com (Girish K S)
Date: Tue, 16 Apr 2013 14:28:53 +0530
Subject: [PATCH 2/2] ARM: dts: add dts node for the ahci sata exynos5440
In-Reply-To: <1366102733-3570-1-git-send-email-ks.giri@samsung.com>
References: <1366102733-3570-1-git-send-email-ks.giri@samsung.com>
Message-ID: <1366102733-3570-2-git-send-email-ks.giri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dts support for the sata controller

Signed-off-by: Girish K S <ks.giri@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 7c5dc38..2dc4ffa 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -220,4 +220,13 @@
 		clock-names = "rtc";
 		status = "disabled";
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
1.7.5.4
