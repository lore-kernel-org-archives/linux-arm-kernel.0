From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri, 21 Oct 2016 23:01:00 +0900
Subject: [PATCH 1/7] ARM: dts: tps65217: Specify the interrupt controller
In-Reply-To: <20161021140106.21531-1-woogyom.kim@gmail.com>
References: <20161021140106.21531-1-woogyom.kim@gmail.com>
Message-ID: <20161021140106.21531-2-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TPS65217 MFD driver supports the IRQ domain to handle the charger input
interrupts and push button status event. The interrupt controller enables
corresponding IRQ handling in the charger[*] and power button driver[**].

[*]  drivers/power/supply/tps65217_charger.c
[**] drivers/input/misc/tps65218-pwrbutton.c

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/tps65217.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
index a632724..27935f8 100644
--- a/arch/arm/boot/dts/tps65217.dtsi
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -13,6 +13,8 @@
 
 &tps {
 	compatible = "ti,tps65217";
+	interrupt-controller;
+	#interrupt-cells = <1>;
 
 	regulators {
 		#address-cells = <1>;
-- 
2.9.3
