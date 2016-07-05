From: t.remmet@phytec.de (Teresa Remmet)
Date: Tue, 5 Jul 2016 11:32:29 +0200
Subject: [PATCH 1/2] ARM: dts: am335x: Update elm phandle binding
Message-ID: <1467711150-23356-1-git-send-email-t.remmet@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The check for the "elm_id" binding had been removed.
This causes nand boot to fail on boards still using
the old binding. Update the bindings on those boards.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm/boot/dts/am335x-baltos.dtsi      | 2 +-
 arch/arm/boot/dts/am335x-igep0033.dtsi    | 2 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
index c8609d8..b689172 100644
--- a/arch/arm/boot/dts/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/am335x-baltos.dtsi
@@ -226,7 +226,7 @@
 
 		#address-cells = <1>;
 		#size-cells = <1>;
-		elm_id = <&elm>;
+		ti,elm-id = <&elm>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index df63484..e7d9ca1 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -161,7 +161,7 @@
 
 		#address-cells = <1>;
 		#size-cells = <1>;
-		elm_id = <&elm>;
+		ti,elm-id = <&elm>;
 
 		/* MTD partition table */
 		partition at 0 {
diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 86f7731..1263c9d 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -197,7 +197,7 @@
 		gpmc,wr-access-ns = <30>;
 		gpmc,wr-data-mux-bus-ns = <0>;
 
-		elm_id = <&elm>;
+		ti,elm-id = <&elm>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.9.1
