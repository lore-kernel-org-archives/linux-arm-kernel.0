From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 28 Jan 2017 22:56:56 +0100
Subject: [PATCH 11/22] ARM: dts: add top-level DT bindings for Cortina
 Gemini
In-Reply-To: <20170123202105.qslqna4ckeyfwame@rob-hp-laptop>
References: <20170122122219.10611-1-linus.walleij@linaro.org>
 <20170123202105.qslqna4ckeyfwame@rob-hp-laptop>
Message-ID: <CACRpkdZbWwfQfdfrAx=HFc6g-PWAt2ZmU88wL3XJYfnPO74Gng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 9:21 PM, Rob Herring <robh@kernel.org> wrote:
> On Sun, Jan 22, 2017 at 01:22:19PM +0100, Linus Walleij wrote:
>> This adds the top level SoC bindings for Cortina systems Gemini
>> platforms.
(...)
>> +- intcon: the root node must have an interrupt controller node pointing to
>
> intcon is just a source label and not meaningful for the binding.

OK

>> +Example:
>> +
>> +/ {
>> +     interrupt-parent = <&intcon>;
>> +
>> +     syscon: syscon at 40000000 {
>
> This chip has no internal bus? Put all these nodes under a bus.

Are you thinking something of the form:

        soc: soc {
                #address-cells = <1>;
                #size-cells = <1>;
                ranges;
                compatible = "simple-bus";

                syscon: syscon at 40000000 {

(...)

?

Yours,
Linus Walleij
