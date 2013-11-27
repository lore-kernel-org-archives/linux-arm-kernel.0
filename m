From: denis@eukrea.com (Denis Carikli)
Date: Wed, 27 Nov 2013 16:54:23 +0100
Subject: [PATCHv8][ 4/5] ARM: dts: mbimxsd51: Add sound support.
In-Reply-To: <1385567664-758-1-git-send-email-denis@eukrea.com>
References: <1385567664-758-1-git-send-email-denis@eukrea.com>
Message-ID: <1385567664-758-4-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel at alsa-project.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v7->v8:
- Ajusted to match the driver changes.
---
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
index cf2e0d8..6774c66 100644
--- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
@@ -48,6 +48,14 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	sound {
+		compatible = "eukrea,asoc-tlv320";
+		eukrea,model = "imx51-eukrea-tlv320aic23";
+		ssi-controller = <&ssi2>;
+		fsl,mux-int-port = <2>;
+		fsl,mux-ext-port = <3>;
+	};
 };
 
 &audmux {
@@ -125,6 +133,7 @@
 };
 
 &ssi2 {
+	codec-handle = <&tlv320aic23>;
 	fsl,mode = "i2s-slave";
 	status = "okay";
 };
-- 
1.7.9.5
