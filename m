From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Jun 2013 18:44:04 +0200
Subject: [PATCH 2/2] sunxi: a10s: dtsi: Convert cpu node to the new cpu
 bindings
In-Reply-To: <1372437844-16325-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1372437844-16325-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1372437844-16325-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10s DTSI was merged without the newer cpu bindings, leading to a
warning being displayed at boot time.

Convert the A10s DTSI to these new bindings, and thus remove the
warning.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 2307ce8..55c086e 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -18,7 +18,9 @@
 
 	cpus {
 		cpu at 0 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a8";
+			reg = <0x0>;
 		};
 	};
 
-- 
1.8.3.1
