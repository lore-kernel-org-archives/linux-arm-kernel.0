From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Thu, 12 Jul 2018 10:02:37 -0300
Subject: [PATCH 2/3] ARM: dts: imx51-babbage: Enable secure-reg-access
In-Reply-To: <1531400558-20700-1-git-send-email-fabio.estevam@nxp.com>
References: <1531400558-20700-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1531400558-20700-2-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 'secure-reg-access' property to enable PMU and hardware counters
so that they can be properly used with the 'perf' tool.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx51-babbage.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index a4a6d4a..ba60b0c 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -396,6 +396,10 @@
 	status = "okay";
 };
 
+&pmu {
+	secure-reg-access;
+};
+
 &ssi2 {
 	status = "okay";
 };
-- 
2.7.4
