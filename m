From: xander.huff@ni.com (Xander Huff)
Date: Thu, 7 May 2015 17:32:25 -0500
Subject: [PATCH 6/6] ARM: Zynq: DT: Enable xadc node in zynq-zybo.dts
In-Reply-To: <1431037945-40360-1-git-send-email-xander.huff@ni.com>
References: <1431037945-40360-1-git-send-email-xander.huff@ni.com>
Message-ID: <1431037945-40360-6-git-send-email-xander.huff@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that zynq-7000 disables xadc by default, enable in zynq-zybo
to retain existing behavior.

Signed-off-by: Xander Huff <xander.huff@ni.com>
---
 arch/arm/boot/dts/zynq-zybo.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
index a9a12ce..a6298fb 100644
--- a/arch/arm/boot/dts/zynq-zybo.dts
+++ b/arch/arm/boot/dts/zynq-zybo.dts
@@ -27,6 +27,12 @@
 		bootargs = "console=ttyPS0,115200 earlyprintk";
 	};
 
+	amba {
+		adc: adc at f8007100 {
+			status = "okay";
+		};
+	};
+
 };
 
 &clkc {
-- 
1.9.1
