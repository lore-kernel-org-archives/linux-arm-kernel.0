From: dongsheng.wang@freescale.com (Dongsheng Wang)
Date: Tue, 1 Dec 2015 16:02:57 +0800
Subject: [RESEND 2/2] ARM: dts: ls1021a: Add a TFT LCD panel dts node
In-Reply-To: <1448956977-8930-1-git-send-email-dongsheng.wang@freescale.com>
References: <1448956977-8930-1-git-send-email-dongsheng.wang@freescale.com>
Message-ID: <1448956977-8930-2-git-send-email-dongsheng.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jianwei Wang <jianwei.wang.chn@gmail.com>

Add a TFT LCD panel. the TFT LCD panel is WQVGA "480x272",
and the bpp is 24.

Signed-off-by: Alison Wang <alison.wang@freescale.com>
Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Jianwei Wang <jianwei.wang.chn@gmail.com>
Signed-off-by: Yi Meng <b56799@freescale.com>
Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index fbb89d1..fad2e3b 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -105,6 +105,17 @@
 			bitclock-master;
 		};
 	};
+
+	panel: panel {
+		compatible = "nec,nl4827hc19-05b";
+	};
+
+};
+
+&dcu {
+	fsl,panel = <&panel>;
+	status = "okay";
+
 };
 
 &dspi1 {
-- 
2.1.0.27.g96db324
