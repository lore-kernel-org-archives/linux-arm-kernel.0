From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed,  3 Apr 2013 18:13:56 +0200
Subject: [PATCH/RFC 3/3] ARM: shmobile: kzm9g-reference: add a TWD DT node
In-Reply-To: <1365005636-17526-1-git-send-email-g.liakhovetski@gmx.de>
References: <1365005636-17526-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1365005636-17526-4-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the use of TWD on kzm9g-reference.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index b6f759e..ed9dd45 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -40,6 +40,13 @@
 		reg = <0x41000000 0x1e800000>;
 	};
 
+	timer at f0000600 {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0xf0000600 0x20>;
+		interrupt-parent = <&gic>;
+		interrupts = <1 13 0x4>;
+	};
+
 	reg_1p8v: regulator at 0 {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
-- 
1.7.2.5
