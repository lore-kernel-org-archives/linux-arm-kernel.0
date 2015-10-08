From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Thu,  8 Oct 2015 15:31:15 +0200
Subject: [PATCH v4 4/8] ARM: dts: rockchip: Add SPDIF optical out on Radxa Rock
In-Reply-To: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1444311079-2892-5-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the SPDIF optical audio output on the Radxa Rock

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

Changes in v4: None
Changes in v3:
- Resent patches to a more complete list of maintainers.

Changes in v2: None

 arch/arm/boot/dts/rk3188-radxarock.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index d2180e5..797f83dd 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -90,6 +90,21 @@
 		};
 	};
 
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "SPDIF";
+
+		simple-audio-card,dai-link at 1 {  /* S/PDIF - S/PDIF */
+			cpu { sound-dai = <&spdif>; };
+			codec { sound-dai = <&spdif_out>; };
+		};
+	};
+
+	spdif_out: spdif-out {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+	};
+
 	ir_recv: gpio-ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio0 10 1>;
@@ -343,6 +358,10 @@
 	};
 };
 
+&spdif {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.6.1
