From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 16 Jan 2013 18:08:14 +0100
Subject: [PATCH 5/8] ARM: shmobile: add a GPIO controller DT node for sh7372
In-Reply-To: <1358356097-26180-1-git-send-email-g.liakhovetski@gmx.de>
References: <1358356097-26180-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1358356097-26180-6-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a missing GPIO controller node to sh7372.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/boot/dts/sh7372.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sh7372.dtsi b/arch/arm/boot/dts/sh7372.dtsi
index 582fdec..7ca9322 100644
--- a/arch/arm/boot/dts/sh7372.dtsi
+++ b/arch/arm/boot/dts/sh7372.dtsi
@@ -19,6 +19,14 @@
 		};
 	};
 
+	gpio: pfc at e6050000 {
+		compatible = "renesas,pfc-sh7372";
+		reg = <0xe6050000 0x8000>,
+		      <0xe605800c 0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
1.7.2.5
