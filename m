From: jianwei.wang.chn@gmail.com (Jianwei Wang)
Date: Thu, 27 Aug 2015 12:19:58 +0800
Subject: [PATCH 2/2] arm:dts:ls1021a: Add SiI902x dts node
In-Reply-To: <1440649198-27244-1-git-send-email-jianwei.wang.chn@gmail.com>
References: <1440649198-27244-1-git-send-email-jianwei.wang.chn@gmail.com>
Message-ID: <1440649198-27244-2-git-send-email-jianwei.wang.chn@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SiI902x is a HDMI transmitter.

Signed-off-by: Alison Wang <b18965@freescale.com>
Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Jianwei Wang <jianwei.wang.chn@gmail.com>
---
 arch/arm/boot/dts/ls1021a-twr.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index a2c591e..c3140f0 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -79,6 +79,12 @@
 
 &i2c1 {
 	status = "okay";
+
+	hdmi: sii9022a at 39 {
+		compatible = "sii902x";
+		reg = <0x39>;
+		interrupts = <GIC_SPI 167 IRQ_TYPE_EDGE_RISING>;
+		};
 };
 
 &ifc {
-- 
2.1.0.27.g96db324
