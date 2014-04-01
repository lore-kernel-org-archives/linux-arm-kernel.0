From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 01 Apr 2014 11:31:57 +0200
Subject: [PATCH RFC v4 2/2] clk: Add handling of clk parent and rate
 assigned from DT
In-Reply-To: <20140401062306.GS17250@pengutronix.de>
References: <1396284116-19178-1-git-send-email-s.nawrocki@samsung.com>
 <1396284116-19178-3-git-send-email-s.nawrocki@samsung.com>
 <5339A036.6090703@codethink.co.uk> <20140401062306.GS17250@pengutronix.de>
Message-ID: <533A878D.8080302@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/14 08:23, Sascha Hauer wrote:
>> tree/bindings/clock/clock-bindings.txt
>> > b/Documentation/devicetree/bindings/clock/clock-bindings.txt
>>> > >index 700e7aa..59fbb4e 100644
>>> > >--- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
>>> > >+++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
>>> > >@@ -132,3 +132,45 @@ clock signal, and a UART.
>>> > >    ("pll" and "pll-switched").
>>> > >  * The UART has its baud clock connected the external oscillator and its
>>> > >    register clock connected to the PLL clock (the "pll-switched" signal)
>>> > >+
>>> > >+==Assigned clock parents and rates==
>>> > >+
>>> > >+Some platforms require static initial configuration of parts of the clocks
>>> > >+controller. Such a configuration can be specified in a clock consumer node
>>> > >+through clock-parents and clock-rates DT properties. The former should
>>> > >+contain a list of parent clocks in form of phandle and clock specifier pairs,
>>> > >+the latter the list of assigned clock frequency values (one cell each).
>>> > >+
>>> > >+    uart at a000 {
>>> > >+        compatible = "fsl,imx-uart";
>>> > >+        reg = <0xa000 0x1000>;
>>> > >+        ...
>>> > >+        clocks = <&clkcon 0>, <&clkcon 3>;
>>> > >+        clock-names = "baud", "mux";
>>> > >+
>>> > >+        clock-parents = <0>, <&pll 1>;
>>> > >+        clock-rates = <460800>;
>>> > >+    };
>>> > >+
>>> > >+In this example the pll is set as parent of "mux" clock and frequency of "baud"
>>> > >+clock is specified as 460800 Hz.
[...]
>> > 
>> > How do you support not-setting a rate for a clock?
>
> Not setting a rate is supported by specifying the rate to 0. That should
> be documented of course.

Yes, a rate won't be set for a clock if its corresponding entry in
clock-rates property is set to 0. Sorry, should have mentioned it.

Would adding a sentence as below to end of the first paragraph above
make it clear ?

"To skip setting a rate or parent for a clock the value of a corresponding
entry in the clock-rates or clock-parents property respectively should
be set to 0. The trailing zeros can be omitted."

--
Thanks,
Sylwester
