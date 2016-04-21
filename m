From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 21 Apr 2016 12:04:26 +0100
Subject: [PATCH 09/18] ASoC: sti: Update DT example to match the driver code
In-Reply-To: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1461236675-10176-10-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

uniperiph-id, version and mode are ST specific bindings and
need the 'st,' prefix. Update the examples, as otherwise copying
them yields a runtime error parsing the DT node.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: arnaud.pouliquen at st.com
---
 .../devicetree/bindings/sound/st,sti-asoc-card.txt         | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
index 028fa1c..ef2e0c6 100644
--- a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
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
