From: d-gerlach@ti.com (Dave Gerlach)
Date: Mon, 9 May 2016 16:49:23 -0500
Subject: [PATCH 3/6] ARM: dts: omap3-n900: Add secure reserved region to
 ocmcram node
In-Reply-To: <1462830566-28708-1-git-send-email-d-gerlach@ti.com>
References: <1462830566-28708-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1462830566-28708-4-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platforms with secure silicon, like omap3-n900, need to mark off a
section of the ocmcram as reserved because it is used by secure
software.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index b3c26a96a726..448452a76c23 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -1004,3 +1004,10 @@
 &ssi_port2 {
 	status = "disabled";
 };
+
+&ocmcram {
+	sram-hs at 0 {
+		compatible = "ti,secure-ram";
+		reg = <0x0 0xC000>;
+	};
+};
-- 
2.7.3
