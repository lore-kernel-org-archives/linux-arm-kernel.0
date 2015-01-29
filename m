From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 29 Jan 2015 16:00:05 +0100
Subject: [PATCH v3 3/6] mmc: pwrseq: Document optional clock for the simple
 power sequence
In-Reply-To: <1422543608-24704-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1422543608-24704-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1422543608-24704-4-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some WLAN chips attached to a SDIO interface, need an external clock
to be operational. Since this is very common, extend the simple MMC
power sequence DT binding to support an optional clock.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Changes since v2: None.

Changes since v1: None.
---
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
index eaae652213ae..a462c50f19a8 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
@@ -12,6 +12,10 @@ Optional properties:
 	at initialization and prior we start the power up procedure of the card.
 	They will be de-asserted right after the power has been provided to the
 	card.
+- clocks : Must contain an entry for the entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names : Must include the following entry:
+  "ext_clock" (External clock provided to the card).
 
 Example:
 
-- 
2.1.3
