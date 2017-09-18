From: andrzej.p@samsung.com (Andrzej Pietrasiewicz)
Date: Mon, 18 Sep 2017 12:02:13 +0200
Subject: [PATCH 1/2] ARM: dts: exynos: Add dwc3 SUSPHY quirk
In-Reply-To: <1505728934-6200-1-git-send-email-andrzej.p@samsung.com>
References: <1505728934-6200-1-git-send-email-andrzej.p@samsung.com>
 <CGME20170918100230eucas1p29fae00c53f1106af1961a6e269740b2f@eucas1p2.samsung.com>
Message-ID: <1505728934-6200-2-git-send-email-andrzej.p@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Odroid XU4 board does not enumerate SuperSpeed devices.
This patch makes exynos5 series chips use USB SUSPHY quirk,
which solves the problem.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
---
 arch/arm/boot/dts/exynos54xx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index 0389e8a..8ca4fef 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -134,6 +134,7 @@
 				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&usbdrd_phy0 0>, <&usbdrd_phy0 1>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,dis_u3_susphy_quirk;
 			};
 		};
 
@@ -154,6 +155,7 @@
 				reg = <0x12400000 0x10000>;
 				phys = <&usbdrd_phy1 0>, <&usbdrd_phy1 1>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,dis_u3_susphy_quirk;
 			};
 		};
 
-- 
1.9.1
