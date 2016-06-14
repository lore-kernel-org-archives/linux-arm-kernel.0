From: hramrach@gmail.com (Michal Suchanek)
Date: Tue, 14 Jun 2016 06:40:01 +0200
Subject: [linux-sunxi] [PATCH v3 11/13] dt: spi: sun4i: merge sun4i and
 sun6i binding doc
In-Reply-To: <CAGRGNgWXG_d2ScrgehbSHguF-V0cXy-Vr1=zLE36v5rDu6pYtQ@mail.gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com>
 <cccbd6c3f0a194ec6eecd6627c4874da7b936f37.1465490774.git.hramrach@gmail.com>
 <CAGRGNgWXG_d2ScrgehbSHguF-V0cXy-Vr1=zLE36v5rDu6pYtQ@mail.gmail.com>
Message-ID: <CAOMqctTtpZ-kCJNUO7NZ855444LuAnsJewjK=nEOaoy0NOT3OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 June 2016 at 01:45, Julian Calaby <julian.calaby@gmail.com> wrote:
> Hi Michal,
>
> On Tue, Jun 14, 2016 at 3:46 AM, Michal Suchanek <hramrach@gmail.com> wrote:
>> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
>> ---
>>  .../devicetree/bindings/spi/spi-sun4i.txt          | 21 ++++++++++---------
>>  .../devicetree/bindings/spi/spi-sun6i.txt          | 24 ----------------------
>>  2 files changed, 11 insertions(+), 34 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-sun6i.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-sun4i.txt b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
>> index de827f5..329e543 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-sun4i.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
>> @@ -1,7 +1,8 @@
>> -Allwinner A10 SPI controller
>> +Allwinner A10/A31 SPI controller
>>
>>  Required properties:
>> -- compatible: Should be "allwinner,sun4-a10-spi".
>> +- compatible: Should be one of "allwinner,sun4i-a10-spi" and
>> +                               "allwinner,sun6i-a31-spi"
>>  - reg: Should contain register location and length.
>>  - interrupts: Should contain interrupt.
>>  - clocks: phandle to the clocks feeding the SPI controller. Two are
>> @@ -9,16 +10,16 @@ Required properties:
>>    - "ahb": the gated AHB parent clock
>>    - "mod": the parent module clock
>>  - clock-names: Must contain the clock names described just above
>> +- resets: (sun6i only) phandle to the reset controller asserting
>> +         this device in reset
>>
>>  Example:
>>
>> -spi1: spi at 01c06000 {
>> -       compatible = "allwinner,sun4i-a10-spi";
>> -       reg = <0x01c06000 0x1000>;
>> -       interrupts = <11>;
>> -       clocks = <&ahb_gates 21>, <&spi1_clk>;
>> +spi1: spi at 01c69000 {
>> +       compatible = "allwinner,sun6i-a31-spi";
>> +       reg = <0x01c69000 0x1000>;
>> +       interrupts = <0 66 4>;
>> +       clocks = <&ahb1_gates 21>, <&spi1_clk>;
>>         clock-names = "ahb", "mod";
>> -       status = "disabled";
>> -       #address-cells = <1>;
>> -       #size-cells = <0>;
>> +       resets = <&ahb1_rst 21>;
>
> Why not have an example of each type?

How many binding docs have examples of all types?

There are actual DTs using these so you can look at those as well.

This driver covers 3 types of bindings which look different in the DT:

sun4i IP with some Chinese interrupt controller, sun4i IP with GIC,
and sun6i IP with GIC.

Thanks

Michal
