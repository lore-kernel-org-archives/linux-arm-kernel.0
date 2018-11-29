From: anson.huang@nxp.com (Anson Huang)
Date: Thu, 29 Nov 2018 01:50:26 +0000
Subject: [PATCH V4 4/4] ARM64: dts: imx: add i.MX8QXP system controller RTC
 support
In-Reply-To: <1543455856-18021-1-git-send-email-Anson.Huang@nxp.com>
References: <1543455856-18021-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1543455856-18021-5-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i.MX8QXP system controller RTC support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog:
V3->V4:
  *move sc rtc to inside of SCU node.
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 9155d45..b38730a 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -84,6 +84,10 @@
 			compatible = "fsl,imx8qxp-scu-pd";
 			#power-domain-cells = <1>;
 		};
+
+		rtc: rtc {
+			compatible = "fsl,imx8qxp-sc-rtc";
+		};
 	};
 
 	tsens: thermal-sensor {
-- 
2.7.4
