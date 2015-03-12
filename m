From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 12 Mar 2015 14:37:11 +0100
Subject: [PATCH v2 RESEND 4/4] ARM: dts: exynos5420: add async-bridge clocks to
 gsc power domain
In-Reply-To: <1426167431-24470-1-git-send-email-a.hajda@samsung.com>
References: <1426167431-24470-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1426167431-24470-5-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both GSCALER IPs in gsc power domain have async-bridges (to FIMD and MIXER),
therefore their clocks should be enabled during power domain switch.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5420.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 55e3887..4eaeabe 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -251,6 +251,8 @@
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10044000 0x20>;
 		#power-domain-cells = <0>;
+		clocks = <&clock CLK_GSCL0>, <&clock CLK_GSCL1>;
+		clock-names = "asb0", "asb1";
 	};
 
 	isp_pd: power-domain at 10044020 {
-- 
1.9.1
