From: denis@eukrea.com (Denis Carikli)
Date: Mon, 21 Oct 2013 14:02:27 +0200
Subject: [PATCHv4][ 3/4] ARM: dts: cpuimx25, mbimxsd25: Add sound support.
In-Reply-To: <1382356948-2905-1-git-send-email-denis@eukrea.com>
References: <1382356948-2905-1-git-send-email-denis@eukrea.com>
Message-ID: <1382356948-2905-3-git-send-email-denis@eukrea.com>
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
ChangeLog v2->v4:
- This patch was splitted, only the part enabling the audio was kept.
  Part of the rest has already been submited, and the remaining parts
  will be submited later, because they depend on changes touching other
  subsystems.
---
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
index be24a85..9d1261d 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
@@ -48,6 +48,15 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	sound {
+		compatible = "eukrea,eukrea-tlv320";
+		model = "imx25-eukrea-tlv320aic23";
+		ssi-controller = <&ssi1>;
+		fsl,audio-codec = <&tlv320aic23>;
+		mux-int-port = <1>;
+		mux-ext-port = <5>;
+	};
 };
 
 &audmux {
-- 
1.7.9.5
