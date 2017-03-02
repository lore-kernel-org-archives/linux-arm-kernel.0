From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Thu, 02 Mar 2017 19:20:14 +0900
Subject: [PATCH v3 2/7] arm: dts: Add the burst and esc clock frequency
 properties for exynos3250 dts
In-Reply-To: <1488450019-6482-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1488450019-6482-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170302102113epcas1p343e9da20f05be0a2359bf32834626c4a@epcas1p3.samsung.com>
Message-ID: <1488450019-6482-3-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OF graph is not needed because the panel is a child of dsi. So
added the burst and esc clock frequency properties to the parent (DSI
node), taking into account the bisectability problem so that remove
the OF graph from DSI node.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/arm/boot/dts/exynos3250-rinato.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 548413e..c9f191c 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -215,6 +215,8 @@
 &dsi_0 {
 	vddcore-supply = <&ldo6_reg>;
 	vddio-supply = <&ldo6_reg>;
+	samsung,burst-clock-frequency = <250000000>;
+	samsung,esc-clock-frequency = <20000000>;
 	samsung,pll-clock-frequency = <24000000>;
 	status = "okay";
 
-- 
1.9.1
