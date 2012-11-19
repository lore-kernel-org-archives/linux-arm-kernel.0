From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 19 Nov 2012 15:45:27 +0100
Subject: [PATCH 3/5] ARM: dts: exynos4210-trats: Add node for i2c3 bus
In-Reply-To: <1353336329-20818-1-git-send-email-t.figa@samsung.com>
References: <1353336329-20818-1-git-send-email-t.figa@samsung.com>
Message-ID: <1353336329-20818-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree node for i2c3 bus to device tree source
of Samsung Trats board. This bus is used by mms114 touchscreen
controller, for which support will be added in separate patch.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4210-trats.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index dcfa04b..1d502bd 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -98,6 +98,15 @@
 		};
 	};
 
+	i2c at 13890000 {
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-slave-addr = <0x10>;
+		samsung,i2c-max-bus-freq = <400000>;
+		pinctrl-0 = <&i2c3_bus>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+
 	i2c at 138B0000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-slave-addr = <0x10>;
-- 
1.8.0
