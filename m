From: xander.huff@ni.com (Xander Huff)
Date: Thu, 7 May 2015 17:32:23 -0500
Subject: [PATCH 4/6] ARM: Zynq: DT: Enable xadc node in zynq-zc706.dts
In-Reply-To: <1431037945-40360-1-git-send-email-xander.huff@ni.com>
References: <1431037945-40360-1-git-send-email-xander.huff@ni.com>
Message-ID: <1431037945-40360-4-git-send-email-xander.huff@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that zynq-7000 disables xadc by default, enable in zynq-zc706
to retain existing behavior.

Signed-off-by: Xander Huff <xander.huff@ni.com>
---
 arch/arm/boot/dts/zynq-zc706.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index 850518d..e7f81e3 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -37,6 +37,12 @@
 		compatible = "usb-nop-xceiv";
 		#phy-cells = <0>;
 	};
+
+	amba {
+		adc: adc at f8007100 {
+			status = "okay";
+		};
+	};
 };
 
 &clkc {
-- 
1.9.1
