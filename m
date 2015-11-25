From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 25 Nov 2015 08:39:49 +0200
Subject: [PATCH 17/18] ARM: am57xx: compulab-sb-som: dts: add HDMI connector
In-Reply-To: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448433590-1399-18-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add HDMI connector node without a valid input endpoint.

CompuLab SB-SOM is a carrier board, hence the endpoint
should be added in the board DT with a valid HDMI output.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/compulab-sb-som.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/compulab-sb-som.dtsi b/arch/arm/boot/dts/compulab-sb-som.dtsi
index 402a143..93d7e23 100644
--- a/arch/arm/boot/dts/compulab-sb-som.dtsi
+++ b/arch/arm/boot/dts/compulab-sb-som.dtsi
@@ -39,4 +39,11 @@
 			pixelclk-active = <1>;
 		};
 	};
+
+	hdmi_conn: connector at 0 {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+
+		type = "a";
+	};
 };
-- 
1.9.1
