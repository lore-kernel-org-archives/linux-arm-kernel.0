From: denis@eukrea.com (Denis Carikli)
Date: Wed, 23 Oct 2013 11:16:04 +0200
Subject: [PATCHv6][ 2/4] ARM: dts: mbimxsd51: Add sound support.
In-Reply-To: <1382519766-17359-1-git-send-email-denis@eukrea.com>
References: <1382519766-17359-1-git-send-email-denis@eukrea.com>
Message-ID: <1382519766-17359-2-git-send-email-denis@eukrea.com>
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
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
index 64d8082..7a485a9 100644
--- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
@@ -48,6 +48,15 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	sound {
+		compatible = "eukrea,eukrea-tlv320";
+		model = "imx51-eukrea-tlv320aic23";
+		ssi-controller = <&ssi2>;
+		fsl,audio-codec = <&tlv320aic23>;
+		mux-int-port = <2>;
+		mux-ext-port = <3>;
+	};
 };
 
 &audmux {
-- 
1.7.9.5
