From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 23 Jun 2017 11:49:38 +0200
Subject: [PATCH v2 2/9] dt-bindings: serial/rs485: make rs485-rts-delay
 optional
In-Reply-To: <20170623094945.31908-1-u.kleine-koenig@pengutronix.de>
References: <20170623094945.31908-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20170623094945.31908-3-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a few device trees that specify one of the already optional
properties without also having the up to now required property
rs485-rts-delay. Additionally there is no technical reason to require
rs485-rts-delay and that's also what most drivers implement.

So give existing users and implementers a blessing and document
rs485-rts-delay as optional.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
This is new in v2 and implements the binding update making rs485-rts-delay
optional as suggested by Sascha.

 Documentation/devicetree/bindings/serial/rs485.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/rs485.txt b/Documentation/devicetree/bindings/serial/rs485.txt
index 32b1fa1f2a5b..b8415936dfdb 100644
--- a/Documentation/devicetree/bindings/serial/rs485.txt
+++ b/Documentation/devicetree/bindings/serial/rs485.txt
@@ -5,14 +5,13 @@ the built-in half-duplex mode.
 The properties described hereafter shall be given to a half-duplex capable
 UART node.
 
-Required properties:
+Optional properties:
 - rs485-rts-delay: prop-encoded-array <a b> where:
   * a is the delay between rts signal and beginning of data sent in milliseconds.
       it corresponds to the delay before sending data.
   * b is the delay between end of data sent and rts signal in milliseconds
       it corresponds to the delay after sending data and actual release of the line.
-
-Optional properties:
+  If this property is not specified, <0 0> is assumed.
 - linux,rs485-enabled-at-boot-time: empty property telling to enable the rs485
   feature at boot time. It can be disabled later with proper ioctl.
 - rs485-rx-during-tx: empty property that enables the receiving of data even
-- 
2.11.0
