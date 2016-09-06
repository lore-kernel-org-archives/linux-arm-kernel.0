From: mw@semihalf.com (Marcin Wojtas)
Date: Tue,  6 Sep 2016 19:41:11 +0200
Subject: [PATCH 1/2] arm64: dts: marvell: fix clocksource for CP110 master SPI0
In-Reply-To: <1473183672-12028-1-git-send-email-mw@semihalf.com>
References: <1473183672-12028-1-git-send-email-mw@semihalf.com>
Message-ID: <1473183672-12028-2-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2C and SPI interfaces share common clock trees within the CP110 HW block.
It occurred that SPI0 interface has wrong clock assignment in the device
tree, which is fixed in this commit to a proper value.

Fixes: 728dacc7f4dd ("arm64: dts: marvell: initial DT description of ...")
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
CC: <stable@vger.kernel.org> v4.7+
---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index db1be4c..903b0f6 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -133,7 +133,7 @@
 				#address-cells = <0x1>;
 				#size-cells = <0x0>;
 				cell-index = <1>;
-				clocks = <&cpm_syscon0 0 3>;
+				clocks = <&cpm_syscon0 1 21>;
 				status = "disabled";
 			};
 
-- 
1.8.3.1
