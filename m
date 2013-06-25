From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 25 Jun 2013 17:38:26 +0200
Subject: [PATCH 4/4] ARM: dts: exynos4210-trats: Enable USB gadget
 functionality
In-Reply-To: <1372174706-5459-1-git-send-email-t.figa@samsung.com>
References: <1372174706-5459-1-git-send-email-t.figa@samsung.com>
Message-ID: <1372174706-5459-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree nodes necessary to enable USB gadget
functionality on Exynos4210-based Trats board.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4210-trats.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 9a14484..d2ce1cf 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -39,6 +39,12 @@
 		enable-active-high;
 	};
 
+	hsotg at 12480000 {
+		vusb_d-supply = <&vusb_reg>;
+		vusb_a-supply = <&vusbdac_reg>;
+		status = "okay";
+	};
+
 	sdhci_emmc: sdhci at 12510000 {
 		bus-width = <8>;
 		non-removable;
@@ -48,6 +54,10 @@
 		status = "okay";
 	};
 
+	usbphy at 125B0000 {
+		status = "okay";
+	};
+
 	serial at 13800000 {
 		status = "okay";
 	};
-- 
1.8.2.1
