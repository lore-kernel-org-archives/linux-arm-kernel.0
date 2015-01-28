From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 28 Jan 2015 11:10:17 +0100
Subject: [PATCH 3/5] mmc: pwrseq: Document optional clock for the simple power
 sequence
In-Reply-To: <1422439819-29854-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1422439819-29854-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1422439819-29854-4-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some WLAN chips attached to a SDIO interface, need an external clock
to be operational. Since this is very common, extend the simple MMC
power sequence DT binding to support an optional clock.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
index 9a77deb164c7..6b5c10d1144c 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
@@ -11,6 +11,10 @@ Optional properties:
 - reset-gpios : contains a list of GPIO specifiers. The reset GPIOs are asserted
 	at initialization and prior we start the power up procedure of the card.
 	Will be de-asserted right after the power has been provided to the card.
+- clocks : Must contain an entry for the entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names : Must include the following entry:
+  "ext_clock" (External clock provided to the card).
 
 Example:
 
-- 
2.1.3
