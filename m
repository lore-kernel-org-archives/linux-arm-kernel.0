From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 1 Mar 2018 14:30:23 +0000
Subject: [PATCH v3 1/2] dt-bindings: i2c: add binding for Socionext
 SynQuacer I2C
In-Reply-To: <CAL_JsqJL9idphGUyZ8M4MuF2oTUC0hNYaVsbLu4ec+=s90qJ1w@mail.gmail.com>
References: <20180227110107.30259-1-ard.biesheuvel@linaro.org>
 <20180227110107.30259-2-ard.biesheuvel@linaro.org>
 <CAL_JsqJL9idphGUyZ8M4MuF2oTUC0hNYaVsbLu4ec+=s90qJ1w@mail.gmail.com>
Message-ID: <CAKv+Gu-W=GuRphju6EZvgC9PK_Gv5Hsxe5Dzp8vFhW-xROokrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 March 2018 at 14:28, Rob Herring <robh+dt@kernel.org> wrote:
> On Tue, Feb 27, 2018 at 5:01 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> Add a binding for the I2C controller that can be found in the Socionext
>> SynQuacer SoC. Note that this is the exact same IP as the Fujitsu F_I2C.
>
> Is there a binding for that? Should be the same doc if so.
>

No, there isn't. That support never made it upstream, but I thought
it'd be useful to mention it given the Fujitsu -> Socionext name
change.

>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/i2c/i2c-synquacer.txt | 29 ++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-synquacer.txt b/Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
>> new file mode 100644
>> index 000000000000..4d0bb6a71211
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
>> @@ -0,0 +1,29 @@
>> +Socionext SynQuacer I2C
>> +
>> +Required properties:
>> +- compatible      : Must be "socionext,synquacer-i2c"
>> +- reg             : Offset and length of the register set for the device
>> +- interrupts      : the interrupt specifier
>
> How many?
>

A single one, will change

>> +- #address-cells  : Must be <1>;
>> +- #size-cells     : Must be <0>;
>> +- clock-names     : Must contain "pclk".
>> +- clocks          : Must contain an entry for each name in clock-names.
>> +                    (See the common clock bindings.)
>> +
>> +Optional properties:
>> +- clock-frequency : Desired I2C bus clock frequency in Hz. As only Normal and
>> +                    Fast modes are supported, possible values are 100000 and
>> +                    400000.
>> +
>> +Example :
>> +
>> +    i2c at 51210000 {
>> +        compatible = "socionext,synquacer-i2c";
>> +        reg = <0x51210000 0x1000>;
>> +        interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        clock-names = "pclk";
>> +        clocks = <&clk_i2c>;
>> +        clock-frequency = <400000>;
>> +    };
>> --
>> 2.11.0
>>
