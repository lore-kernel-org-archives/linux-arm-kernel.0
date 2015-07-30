From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 30 Jul 2015 13:43:36 +0530
Subject: [PATCH 3/7] ARM: dts: dra72-evm: Set max clock frequency of MMC1 and
 MMC2
In-Reply-To: <1438244020-4244-1-git-send-email-kishon@ti.com>
References: <1438244020-4244-1-git-send-email-kishon@ti.com>
Message-ID: <1438244020-4244-4-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MMC1 supports SDR104 and MMC2 supports HS200 both of which requires
192MHz clock. Set the maximum operating clock frequency to 192 MHz.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 3998d37..c5d8e7d 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -508,6 +508,7 @@
 	 * is a viable alternative
 	 */
 	cd-gpios = <&gpio6 27 0>;
+	max-frequency = <192000000>;
 };
 
 &mmc2 {
@@ -519,6 +520,7 @@
 	vmmc-supply = <&evm_3v3>;
 	bus-width = <8>;
 	ti,non-removable;
+	max-frequency = <192000000>;
 };
 
 &dra7_pmx_core {
-- 
1.7.9.5
