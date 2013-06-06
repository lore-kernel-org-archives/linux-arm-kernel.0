From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  6 Jun 2013 18:41:25 +0200
Subject: [PATCH v2 5/8] arm: mvebu: the MPIC now provides MSI controller
 features
In-Reply-To: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1370536888-8871-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds the 'msi-controller' property to the main interrupt controller
Device Tree node, to indicate that it can now behave as a MSI
controller.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index bb6224c..9020478 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -52,6 +52,7 @@
 				#interrupt-cells = <1>;
 				#size-cells = <1>;
 				interrupt-controller;
+				msi-controller;
 			};
 
 			coherency-fabric at 20200 {
-- 
1.8.1.2
