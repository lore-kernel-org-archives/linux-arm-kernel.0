From: karthik@techveda.org (karthik at techveda.org)
Date: Tue, 27 Jun 2017 12:17:40 +0530
Subject: [PATCH v2] arm: dts: omap3: Remove needless interrupt-parent property
In-Reply-To: <41ab5d17-620e-34b6-bd1c-33ae7bb3234c@techveda.org>
References: <41ab5d17-620e-34b6-bd1c-33ae7bb3234c@techveda.org>
Message-ID: <1498546060-5742-1-git-send-email-karthik@techveda.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Karthik Tummala <karthik@techveda.org>

All nodes inhert "interrupt-parent" property from root
node. Removed the aforementioned property from usbhsohci,
usbhsehci, ssi_port1, ssi_port2 nodes to avoid duplication.

Signed-off-by: Karthik Tummala <karthik@techveda.org>
---
Changes for v2:
- Made changes to subject & description as suggested by
  Suniel Mahesh.
---
 arch/arm/boot/dts/omap3.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index a3ff493..bdaf30c 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -713,14 +713,12 @@
 			usbhsohci: ohci at 48064400 {
 				compatible = "ti,ohci-omap3";
 				reg = <0x48064400 0x400>;
-				interrupt-parent = <&intc>;
 				interrupts = <76>;
 			};
 
 			usbhsehci: ehci at 48064800 {
 				compatible = "ti,ehci-omap";
 				reg = <0x48064800 0x400>;
-				interrupt-parent = <&intc>;
 				interrupts = <77>;
 			};
 		};
@@ -831,7 +829,6 @@
 				reg-names = "tx",
 					    "rx";
 
-				interrupt-parent = <&intc>;
 				interrupts = <67>,
 					     <68>;
 			};
@@ -844,7 +841,6 @@
 				reg-names = "tx",
 					    "rx";
 
-				interrupt-parent = <&intc>;
 				interrupts = <69>,
 					     <70>;
 			};
-- 
1.9.1
