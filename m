From: xander.huff@ni.com (Xander Huff)
Date: Thu, 7 May 2015 17:32:21 -0500
Subject: [PATCH 2/6] ARM: Zynq: DT: Enable xadc node in zynq-parallella.dts
In-Reply-To: <1431037945-40360-1-git-send-email-xander.huff@ni.com>
References: <1431037945-40360-1-git-send-email-xander.huff@ni.com>
Message-ID: <1431037945-40360-2-git-send-email-xander.huff@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that zynq-7000 disables xadc by default, enable in zynq-parallella
to retain existing behavior.

Signed-off-by: Xander Huff <xander.huff@ni.com>
---
 arch/arm/boot/dts/zynq-parallella.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 1745712..b1a1f7a 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -32,6 +32,12 @@
 		bootargs = "console=ttyPS0,115200 earlyprintk root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait";
 		linux,stdout-path = "/amba/serial at e0001000";
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
