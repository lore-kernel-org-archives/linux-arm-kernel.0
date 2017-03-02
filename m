From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Thu, 02 Mar 2017 19:20:15 +0900
Subject: [PATCH v3 3/7] arm: dts: Add the burst and esc clock frequency
 properties for exynos4412 dts
In-Reply-To: <1488450019-6482-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1488450019-6482-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170302102113epcas5p4c93024f46ed53ac962b332b559553cd5@epcas5p4.samsung.com>
Message-ID: <1488450019-6482-4-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OF graph is not needed because the panel is a child of dsi. So
added the burst and esc clock frequency properties to the parent (DSI
node), taking into account the bisectability problem so that remove
the OF graph from DSI node.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 41ecd6d..82221a0 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -385,6 +385,8 @@
 &dsi_0 {
 	vddcore-supply = <&ldo8_reg>;
 	vddio-supply = <&ldo10_reg>;
+	samsung,burst-clock-frequency = <500000000>;
+	samsung,esc-clock-frequency = <20000000>;
 	samsung,pll-clock-frequency = <24000000>;
 	status = "okay";
 
-- 
1.9.1
