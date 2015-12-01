From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Tue,  1 Dec 2015 20:03:19 +0200
Subject: [PATCH V2 17/19] ARM: dts: am57xx: compulab-sb-som: add HDMI connector
In-Reply-To: <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448993001-19495-18-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add HDMI connector node without a valid input endpoint.

CompuLab SB-SOM is a carrier board, hence the endpoint
should be added in the board DT with a valid HDMI output.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---

  v2:

   * No fuctional changes
   * Reformat subject

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
