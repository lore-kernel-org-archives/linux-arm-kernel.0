From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 27 Apr 2012 15:03:05 +0800
Subject: [PATCH 11/11] ARM: dts: imx6q-sabrelite: add sound device
 imx6q-sabrelite-sgtl5000
In-Reply-To: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1335510185-7906-12-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Zhao <richard.zhao@linaro.org>

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index cdae2dd..20aa767 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -97,4 +97,17 @@
 			regulator-always-on;
 		};
 	};
+
+	sound {
+		compatible = "fsl,imx6q-sabrelite-sgtl5000",
+			     "fsl,imx-audio-sgtl5000";
+		model = "imx6q-sabrelite-sgtl5000";
+		ssi-controller = <&ssi1>;
+		audio-codec = <&codec>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Headphone Jack", "HP_OUT";
+		mux-int-port = <1>;
+		mux-ext-port = <4>;
+	};
 };
-- 
1.7.5.4
