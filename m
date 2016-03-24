From: david@lechnology.com (David Lechner)
Date: Thu, 24 Mar 2016 18:51:37 -0500
Subject: [PATCH v3 12/16] ARM: dt: da850: Add cfgchip syscon node
In-Reply-To: <1458863503-31121-1-git-send-email-david@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
Message-ID: <1458863503-31121-13-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a syscon node for the SoC CFGCHIPn registers. This is needed for
the new usb phy driver.

Signed-off-by: David Lechner <david@lechnology.com>
---

v3 changes: This is a new patch.


 arch/arm/boot/dts/da850.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 4294849..a360713 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -150,6 +150,10 @@
 			};
 
 		};
+		cfgchip: cfgchip at 1417c {
+			compatible = "ti,da830-cfgchip", "syscon";
+			reg = <0x1417c 0x14>;
+		};
 		edma0: edma at 0 {
 			compatible = "ti,edma3-tpcc";
 			/* eDMA3 CC0: 0x01c0 0000 - 0x01c0 7fff */
-- 
1.9.1
