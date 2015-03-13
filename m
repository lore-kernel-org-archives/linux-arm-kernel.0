From: marek@goldelico.com (Marek Belisko)
Date: Fri, 13 Mar 2015 21:40:37 +0100
Subject: [PATCH v2 2/2] Documentation: omap-twl4030: Move ti,
 codec property to optional
In-Reply-To: <1426279237-15940-1-git-send-email-marek@goldelico.com>
References: <1426279237-15940-1-git-send-email-marek@goldelico.com>
Message-ID: <1426279237-15940-3-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ti,codec property is not used in omap-twl4030 driver in linux kernel but
we keep it as optional property, so that the existing dtbs do not
become noncompliant after the change on other OS.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 Documentation/devicetree/bindings/sound/omap-twl4030.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/omap-twl4030.txt b/Documentation/devicetree/bindings/sound/omap-twl4030.txt
index 1ab6bc8..f6a715e 100644
--- a/Documentation/devicetree/bindings/sound/omap-twl4030.txt
+++ b/Documentation/devicetree/bindings/sound/omap-twl4030.txt
@@ -4,9 +4,9 @@ Required properties:
 - compatible: "ti,omap-twl4030"
 - ti,model: Name of the sound card (for example "omap3beagle")
 - ti,mcbsp: phandle for the McBSP node
-- ti,codec: phandle for the twl4030 audio node
 
 Optional properties:
+- ti,codec: phandle for the twl4030 audio node
 - ti,mcbsp-voice: phandle for the McBSP node connected to the voice port of twl
 - ti, jack-det-gpio: Jack detect GPIO
 - ti,audio-routing: List of connections between audio components.
@@ -59,5 +59,4 @@ sound {
 	ti,model = "omap3beagle";
 
 	ti,mcbsp = <&mcbsp2>;
-	ti,codec = <&twl_audio>;
 };
-- 
1.9.1
