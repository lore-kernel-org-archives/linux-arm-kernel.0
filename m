From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue,  4 Jul 2017 13:59:20 +0200
Subject: [PATCH v2 2/9] clk: at91: add audio plls to the compatible list in DT
 binding
In-Reply-To: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
References: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
Message-ID: <20170704115927.32662-3-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This new clock driver set allows to have a fractional divided clock that
would generate a precise clock particularly suitable for audio
applications.

The main audio pll clock has two children clocks: one that is connected
to the PMC, the other that can directly drive a pad. As these two routes
have different enable bits and different dividers and divider formulas,
they are handled by two different drivers.

This adds the audio plls (frac, pad and pmc) to the compatible list of
at91 clocks in DT binding.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
---

added in v2:
  - split from big patch with pll drivers and dt-binding

 Documentation/devicetree/bindings/clock/at91-clock.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
index 5f3ad65daf69..51c259a92d02 100644
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -81,6 +81,16 @@ Required properties:
 	"atmel,sama5d2-clk-generated":
 		at91 generated clock
 
+	"atmel,sama5d2-clk-audio-pll-frac":
+		at91 audio fractional pll
+
+	"atmel,sama5d2-clk-audio-pll-pad":
+		at91 audio pll CLK_AUDIO output pin
+
+	"atmel,sama5d2-clk-audio-pll-pmc"
+		at91 audio pll output on AUDIOPLLCLK that feeds the PMC
+		and can be used by peripheral clock or generic clock
+
 Required properties for SCKC node:
 - reg : defines the IO memory reserved for the SCKC.
 - #size-cells : shall be 0 (reg is used to encode clk id).
-- 
2.11.0
