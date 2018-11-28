From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 28 Nov 2018 18:53:05 +0100
Subject: [PATCH v4 01/20] dt-bindings: mrvl,mmp-timer: add clock
In-Reply-To: <20181128175324.163202-1-lkundrak@v3.sk>
References: <20181128175324.163202-1-lkundrak@v3.sk>
Message-ID: <20181128175324.163202-2-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer needs the timer clock to be enabled, otherwise it stops
ticking.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- Made the clock optional, to keep compatibility with DTs without it

 Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt b/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
index 9a6e251462e7..b8f02c663521 100644
--- a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
@@ -5,9 +5,13 @@ Required properties:
 - reg : Address and length of the register set of timer controller.
 - interrupts : Should be the interrupt number.
 
+Optional properties:
+- clocks : Should contain a single entry describing the clock input.
+
 Example:
 	timer0: timer at d4014000 {
 		compatible = "mrvl,mmp-timer";
 		reg = <0xd4014000 0x100>;
 		interrupts = <13>;
+		clocks = <&coreclk 2>;
 	};
-- 
2.19.1
