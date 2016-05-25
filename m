From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 25 May 2016 17:06:44 +0100
Subject: [PATCH v4 10/18] ASoC: sti: Update DT example to match the driver code
In-Reply-To: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1464192412-16386-12-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

uniperiph-id, version and mode are ST specific bindings and
need the 'st,' prefix. Update the examples, as otherwise copying
them yields a runtime error parsing the DT node.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: arnaud.pouliquen at st.com
Cc: broonie at kernel.org
---
 .../devicetree/bindings/sound/st,sti-asoc-card.txt   | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
index 028fa1c..fe1b72c 100644
--- a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
@@ -33,7 +33,7 @@ Required properties:
 	"tx" for "st,sti-uni-player" compatibility
 	"rx" for "st,sti-uni-reader" compatibility
 
-  - version: IP version integrated in SOC.
+  - st,version: IP version integrated in SOC.
 
   - dai-name: DAI name that describes the IP.
 
@@ -41,9 +41,9 @@ Required properties ("st,sti-uni-player" compatibility only):
   - clocks: CPU_DAI IP clock source, listed in the same order than the
 	    CPU_DAI properties.
 
-  - uniperiph-id: internal SOC IP instance ID.
+  - st,uniperiph-id: internal SOC IP instance ID.
 
-  - IP mode: IP working mode depending on associated codec.
+  - st,mode: IP working mode depending on associated codec.
 	"HDMI" connected to HDMI codec IP and IEC HDMI formats.
 	"SPDIF"connected to SPDIF codec and support SPDIF formats.
 	"PCM"  PCM standard mode for I2S or TDM bus.
@@ -67,9 +67,9 @@ Example:
 		dmas = <&fdma0 4 0 1>;
 		dai-name = "Uni Player #1 (DAC)";
 		dma-names = "tx";
-		uniperiph-id = <2>;
-		version = <5>;
-		mode = "PCM";
+		st,uniperiph-id = <2>;
+		st,version = <5>;
+		st,mode = "PCM";
 	};
 
 	sti_uni_player3: sti-uni-player at 3 {
@@ -83,9 +83,9 @@ Example:
 		dmas = <&fdma0 7 0 1>;
 		dma-names = "tx";
 		dai-name = "Uni Player #1 (PIO)";
-		uniperiph-id = <3>;
-		version = <5>;
-		mode = "SPDIF";
+		st,uniperiph-id = <3>;
+		st,version = <5>;
+		st,mode = "SPDIF";
 	};
 
 	sti_uni_reader1: sti-uni-reader at 1 {
@@ -98,7 +98,7 @@ Example:
 		dmas = <&fdma0 6 0 1>;
 		dma-names = "rx";
 		dai-name = "Uni Reader #1 (HDMI RX)";
-		version = <3>;
+		st,version = <3>;
 	};
 
 2) sti-sas-codec: internal audio codec IPs driver
-- 
1.9.1
