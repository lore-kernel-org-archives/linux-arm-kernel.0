From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 29 Jun 2017 21:26:37 +0800
Subject: [PATCH 1/2] ASoC: audio-graph-card: update bindings for amplifier
 support
In-Reply-To: <1498742798-3128-1-git-send-email-shawnguo@kernel.org>
References: <1498742798-3128-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1498742798-3128-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

The audio-graph-card should be able to support widgets and routing in
the same way as what simple-audio-card does.  The patch adds the
properties into audio-graph-card bindings.  Then an optional property
'pa-gpios' for controlling external amplifier, which depends on DAPM
widgets and routing, is added.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/sound/audio-graph-card.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
index bac4b1b1060f..6e6720aa33f1 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-card.txt
+++ b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
@@ -10,6 +10,8 @@ see ${LINUX}/Documentation/devicetree/bindings/sound/simple-card.txt
 Below are same as Simple-Card.
 
 - label
+- widgets
+- routing
 - dai-format
 - frame-master
 - bitclock-master
@@ -24,6 +26,9 @@ Required properties:
 - compatible				: "audio-graph-card";
 - dais					: list of CPU DAI port{s}
 
+Optional properties:
+- pa-gpios: GPIO used to control external amplifier.
+
 Example: Single DAI case
 
 	sound_card {
-- 
1.9.1
