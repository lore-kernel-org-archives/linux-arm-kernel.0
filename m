From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 16 Jul 2015 17:27:48 +0200
Subject: [PATCH 1/7] Documentation: mtd: add a DT property to set the number
 of dummy cycles
In-Reply-To: <cover.1437059658.git.cyrille.pitchen@atmel.com>
References: <cover.1437059658.git.cyrille.pitchen@atmel.com>
Message-ID: <0eacf9dac878768b4cf915f926c628d9e65499df.1437059658.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depending on the SPI clock frequency, the Fast Read op code and the
Single/Dual Data Rate mode, the number of dummy cycles can be tuned to
improve transfer speed.
The actual number of dummy cycles is specific for each memory model and is
provided by the manufacturer thanks to the memory datasheet.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
index 2bee68103b01..4387567d8024 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
@@ -19,6 +19,11 @@ Optional properties:
                    all chips and support for it can not be detected at runtime.
                    Refer to your chips' datasheet to check if this is supported
                    by your chip.
+- m25p,num-dummy-cycles : Set the number of dummy cycles for Fast Read commands.
+                          Depending on the manufacturer additional dedicated
+                          commands are sent to the flash memory so the
+                          controller and the memory can agree on the number of
+                          dummy cycles to use.
 
 Example:
 
@@ -29,4 +34,5 @@ Example:
 		reg = <0>;
 		spi-max-frequency = <40000000>;
 		m25p,fast-read;
+		m25p,num-dummy-cycles = <8>;
 	};
-- 
1.8.2.2
