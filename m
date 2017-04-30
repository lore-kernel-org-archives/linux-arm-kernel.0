From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 30 Apr 2017 20:30:54 +0200
Subject: [PATCH 3/3] ARM: dts: rockchip: List charger as power supply for
 minnie
In-Reply-To: <20170430183054.24563-1-contact@paulk.fr>
References: <20170430183054.24563-1-contact@paulk.fr>
Message-ID: <20170430183054.24563-3-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This lists the GPIO charger node as power supply for the battery, which
in turns allows receiving external power notifications and synchronizing
the charging state as soon as possible.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/rk3288-veyron-minnie.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index 544de6027aaa..3f97f33bd783 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -151,6 +151,7 @@
 	battery: bq27500 at 55 {
 		compatible = "ti,bq27500";
 		reg = <0x55>;
+		power-supplies = <&charger>;
 	};
 };
 
-- 
2.12.2
