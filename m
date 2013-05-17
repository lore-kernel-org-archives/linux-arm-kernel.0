From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 17 May 2013 14:26:48 +0200 (CEST)
Subject: [PATCH v3 09/20] ARM: shmobile: r8a7790: Add GPIO controller
 devices to device tree
In-Reply-To: <1368577100-3530-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1368577100-3530-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1368577100-3530-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <Pine.LNX.4.64.1305171423270.31481@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent

On Wed, 15 May 2013, Laurent Pinchart wrote:

> Add GPIO controller nodes to the r8a7790 core device tree.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/boot/dts/r8a7790.dtsi | 54 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)

Also here a couple of things are missing (presumably, for other SoCs you 
need the same):

diff --git a/arch/arm/boot/dts/r8a7790.dtsi 
b/arch/arm/boot/dts/r8a7790.dtsi
index 674ee39..cd1a04f 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -51,6 +51,7 @@
 		interrupts = <0 4 0x4>;
 		#gpio-cells = <2>;
 		gpio-controller;
+		gpio-ranges = <&pfc 0 0 32>;
 	};
 
 	gpio1: gpio at ffc41000 {
@@ -60,6 +61,7 @@
 		interrupts = <0 5 0x4>;
 		#gpio-cells = <2>;
 		gpio-controller;
+		gpio-ranges = <&pfc 0 32 32>;
 	};
 
 	gpio2: gpio at ffc42000 {
@@ -69,6 +71,7 @@
 		interrupts = <0 6 0x4>;
 		#gpio-cells = <2>;
 		gpio-controller;
+		gpio-ranges = <&pfc 0 64 32>;
 	};
 
 	gpio3: gpio at ffc43000 {
@@ -78,6 +81,7 @@
 		interrupts = <0 7 0x4>;
 		#gpio-cells = <2>;
 		gpio-controller;
+		gpio-ranges = <&pfc 0 96 32>;
 	};
 
 	gpio4: gpio at ffc44000 {
@@ -87,6 +91,7 @@
 		interrupts = <0 8 0x4>;
 		#gpio-cells = <2>;
 		gpio-controller;
+		gpio-ranges = <&pfc 0 128 32>;
 	};
 
 	gpio5: gpio at ffc45000 {
@@ -96,6 +101,7 @@
 		interrupts = <0 9 0x4>;
 		#gpio-cells = <2>;
 		gpio-controller;
+		gpio-ranges = <&pfc 0 160 32>;
 	};
 
 	timer {
@@ -118,6 +124,7 @@
 	pfc: pfc at e6060000 {
 		compatible = "renesas,pfc-r8a7790";
 		reg = <0 0xe6060000 0 0x250>;
+		#gpio-range-cells = <3>;
 	};
 
 	/* No MMC_CAP_UHS_DDR50 (dual data rate) capability on r8a7790! */

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
