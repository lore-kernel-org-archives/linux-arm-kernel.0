From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 28 Jan 2013 19:56:19 +0100
Subject: [PATCH v2 10/27] arm: mvebu: fix address-cells in mpic DT node
In-Reply-To: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1359399397-29729-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to have a #address-cells property in the MPIC Device
Tree node, and more than that, having it confuses the of_irq_map_raw()
logic, which will be used by the Marvell PCIe driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 4c0abe8..1dcdae9 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -31,7 +31,6 @@
 	mpic: interrupt-controller at d0020000 {
 	      compatible = "marvell,mpic";
 	      #interrupt-cells = <1>;
-	      #address-cells = <1>;
 	      #size-cells = <1>;
 	      interrupt-controller;
 	};
-- 
1.7.9.5
