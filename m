From: robherring2@gmail.com (Rob Herring)
Date: Fri, 26 Oct 2012 13:43:04 -0500
Subject: [PATCH 2/6] ARM: highbank: enable coherent DMA for xgmac in dts
In-Reply-To: <1351276988-28382-1-git-send-email-robherring2@gmail.com>
References: <1351276988-28382-1-git-send-email-robherring2@gmail.com>
Message-ID: <1351276988-28382-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Enable the xgmac to use the coherent DMA path in highbank.dts

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/highbank.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
index 28d5872..e39a79a 100644
--- a/arch/arm/boot/dts/highbank.dts
+++ b/arch/arm/boot/dts/highbank.dts
@@ -308,12 +308,14 @@
 			compatible = "calxeda,hb-xgmac";
 			reg = <0xfff50000 0x1000>;
 			interrupts = <0 77 4  0 78 4  0 79 4>;
+			dma-coherent;
 		};
 
 		ethernet at fff51000 {
 			compatible = "calxeda,hb-xgmac";
 			reg = <0xfff51000 0x1000>;
 			interrupts = <0 80 4  0 81 4  0 82 4>;
+			dma-coherent;
 		};
 
 		combophy0: combo-phy at fff58000 {
-- 
1.7.10.4
