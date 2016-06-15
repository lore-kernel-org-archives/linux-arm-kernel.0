From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 15 Jun 2016 21:17:49 +0800
Subject: [PATCH v2 02/10] mfd: ac100: Add device tree bindings for
 X-Powers AC100 codec/RTC combo IC
In-Reply-To: <20160615124943.GE4948@dell>
References: <1465986467-14802-1-git-send-email-wens@csie.org>
 <1465986467-14802-3-git-send-email-wens@csie.org> <20160615124943.GE4948@dell>
Message-ID: <CAGb2v66q0h_BZ-kkRZCneOs5yxvcADXKymMskr3CRc-N8Dqm1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 8:49 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 15 Jun 2016, Chen-Yu Tsai wrote:
>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  Documentation/devicetree/bindings/mfd/ac100.txt | 42 +++++++++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/ac100.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/ac100.txt b/Documentation/devicetree/bindings/mfd/ac100.txt
>> new file mode 100644
>> index 000000000000..fbab623e6fba
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/ac100.txt
>> @@ -0,0 +1,42 @@
>> +X-Powers AC100 Codec/RTC IC device tree bindings
>> +
>> +AC100 is a audio codec and RTC subsystem combo IC. The 2 parts are
>> +separated, including power supplies and interrupt lines, but share
>> +a common register address space and host interface.
>> +
>> +Required properties:
>> +- compatible: "x-powers,ac100"
>> +- reg: The I2C slave address or RSB hardware address for the chip
>> +- sub-nodes:
>> +  - codec
>> +    - compatible: "x-powers,ac100-codec"
>> +    - interrupt-parent: The parent interrupt controller
>> +    - interrupts: SoC NMI / GPIO interrupt connected to the IRQ_AUDIO pin
>> +  - rtc
>> +    - compatible: "x-powers,ac100-rtc"
>> +    - interrupt-parent: The parent interrupt controller
>> +    - interrupts: SoC NMI / GPIO interrupt connected to the IRQ_RTC pin
>> +    - #clock-cells: shall be 1
>> +    - clock-output-names: "cko1_rtc", "cko2_rtc", "cko3_rtc"
>> +    - see clock/clock-bindings.txt for common clock bindings
>> +
>> +Example:
>> +
>> +ac100: codec at e89 {
>> +     compatible = "x-powers,ac100";
>> +     reg = <0xe89>;
>> +
>> +     ac100_codec {
>> +             compatible = "x-powers,ac100-codec";
>> +             interrupt-parent = <&nmi_intc>;
>> +             interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +     };
>> +
>> +     ac100_rtc {
>> +             compatible = "x-powers,ac100-rtc";
>> +             interrupt-parent = <&nmi_intc>;
>> +             interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>
> Isn't this the same interrupt as above?  Is it shared?

Copy paste error... The codec uses a different line in the design.

ChenYu

>
>> +             #clock-cells = <1>;
>> +             clock-output-names = "cko1_rtc", "cko2_rtc", "cko3_rtc";
>> +     };
>> +};
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
