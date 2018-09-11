From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 11 Sep 2018 17:10:43 -0300
Subject: [PATCH 2/6] ARM: dts: imx51-zii-scu3-esb: Disable VPU
In-Reply-To: <1536696647-8228-1-git-send-email-festevam@gmail.com>
References: <1536696647-8228-1-git-send-email-festevam@gmail.com>
Message-ID: <1536696647-8228-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx51-zii-scu3-esb does not have any video encoding/decoding needs,
so disable the VPU.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx51-zii-scu3-esb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
index e6ebac8..14b2077 100644
--- a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
+++ b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
@@ -350,6 +350,10 @@
 	vcc-supply = <&vusb2_reg>;
 };
 
+&vpu {
+	status = "disabled";
+};
+
 &wdog1 {
 	status = "disabled";
 };
-- 
2.7.4
