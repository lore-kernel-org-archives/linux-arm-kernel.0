From: pawel.moll@arm.com (Pawel Moll)
Date: Tue,  6 Aug 2013 19:54:22 +0100
Subject: [PATCH 3/5] ARM: vexpress: Add SCC & SPC to V2P-CA15_A7's device tree
In-Reply-To: <1375815264-29414-1-git-send-email-pawel.moll@arm.com>
References: <1375815264-29414-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1375815264-29414-4-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SCC is a set of random system control registers. One of
the functionality provided is an interface to power
management features (SPC).

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index d2803be..004025d 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -125,6 +125,17 @@
 		clock-names = "apb_pclk";
 	};
 
+        scc at 7fff0000 {
+                #address-cells = <1>;
+                #size-cells = <1>;
+                ranges = <0 0 0x7fff0000 0x1000>;
+
+                spc at b00 {
+                        compatible = "arm,vexpress-spc,v2p-ca15_a7", "arm,vexpress-spc";
+                        reg = <0xb00 0x100>;
+                };
+        };
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <1 13 0xf08>,
-- 
1.8.1.2
