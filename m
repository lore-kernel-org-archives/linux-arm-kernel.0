From: tobetter@gmail.com (Dongjin Kim)
Date: Tue,  5 Feb 2013 10:25:22 +0900
Subject: [PATCH 2/2] ARM: dts: Add USBPHY device node for Exynos4412
In-Reply-To: <1360027522-18196-1-git-send-email-tobetter@gmail.com>
References: <1360027522-18196-1-git-send-email-tobetter@gmail.com>
Message-ID: <1360027522-18196-2-git-send-email-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds USBPHY device node for Samsung's Exynos4412 SoC to
arch/arm/boot/dts/exynos4412.dtsi.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/boot/dts/exynos4412.dtsi |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 387aa27..c01d841 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -33,4 +33,17 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
+
+	usbphy at 125B0000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "samsung,exynos4412-usbphy";
+		reg = <0x125B0000 0x100>;
+		status = "disabled";
+		ranges;
+
+		usbphy-sys {
+			reg = <0x10020704 0xc>;
+		};
+	};
 };
-- 
1.7.10.4
