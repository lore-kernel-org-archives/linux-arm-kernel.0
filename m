From: mw@semihalf.com (Marcin Wojtas)
Date: Tue,  6 Sep 2016 19:41:12 +0200
Subject: [PATCH 2/2] arm64: dts: marvell: fix clocksource for CP110 slave SPI0
In-Reply-To: <1473183672-12028-1-git-send-email-mw@semihalf.com>
References: <1473183672-12028-1-git-send-email-mw@semihalf.com>
Message-ID: <1473183672-12028-3-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2C and SPI interfaces share common clock trees within the CP110 HW block.
It occurred that SPI0 interface has wrong clock assignment in the device
tree, which is fixed in this commit to a proper value.

Fixes: c749b8d9de32 ("arm64: dts: marvell: add description for the ...")
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 37bff70..150675c 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -133,7 +133,7 @@
 				#address-cells = <0x1>;
 				#size-cells = <0x0>;
 				cell-index = <1>;
-				clocks = <&cps_syscon0 0 3>;
+				clocks = <&cps_syscon0 1 21>;
 				status = "disabled";
 			};
 
-- 
1.8.3.1
