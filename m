From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 23 Jan 2013 17:37:48 +0100
Subject: [PATCH v3 5/8] ARM: shmobile: add a GPIO controller DT node for sh7372
In-Reply-To: <1358959071-2873-1-git-send-email-g.liakhovetski@gmx.de>
References: <1358959071-2873-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1358959071-2873-6-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a missing GPIO controller node to sh7372.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v3: fix second memory area size.

 arch/arm/boot/dts/sh7372.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sh7372.dtsi b/arch/arm/boot/dts/sh7372.dtsi
index 582fdec..3598e57 100644
--- a/arch/arm/boot/dts/sh7372.dtsi
+++ b/arch/arm/boot/dts/sh7372.dtsi
@@ -19,6 +19,14 @@
 		};
 	};
 
+	gpio: pfc at e6050000 {
+		compatible = "renesas,pfc-sh7372";
+		reg = <0xe6050000 0x8000>,
+		      <0xe605800c 0x1c>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
1.7.2.5
