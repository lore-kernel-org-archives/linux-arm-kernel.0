From: scott.branden@broadcom.com (Scott Branden)
Date: Thu, 17 Aug 2017 11:20:44 -0700
Subject: [PATCH 1/3] dt-bindings: mfd: d1w: iproc: Documentation for d1w
 driver
In-Reply-To: <CABGGiswK7UofmFea4FcNi_fTG+hzhu707Z8Lni7DNRoMtsx0FQ@mail.gmail.com>
References: <1502905525-5646-1-git-send-email-scott.branden@broadcom.com>
 <1502905525-5646-2-git-send-email-scott.branden@broadcom.com>
 <CABGGiswK7UofmFea4FcNi_fTG+hzhu707Z8Lni7DNRoMtsx0FQ@mail.gmail.com>
Message-ID: <5aca8e15-8c4b-59b8-29f2-f100d25698b6@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for review Rob


On 17-08-16 01:45 PM, Rob Herring wrote:
> On Wed, Aug 16, 2017 at 12:45 PM, Scott Branden
> <scott.branden@broadcom.com> wrote:
>> From: Shreesha Rajashekar <shreesha@broadcom.com>
>>
>> Adding document for IPROC d1w driver.
>>
>> Signed-off-by: Shreesha Rajashekar <shreesha@broadcom.com>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   .../devicetree/bindings/mfd/brcm,iproc-d1w.txt     | 27 ++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/brcm,iproc-d1w.txt
> How is this an MFD? Should be bindings/w1/...
>
>> diff --git a/Documentation/devicetree/bindings/mfd/brcm,iproc-d1w.txt b/Documentation/devicetree/bindings/mfd/brcm,iproc-d1w.txt
>> new file mode 100644
>> index 0000000..2bb99c1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/brcm,iproc-d1w.txt
>> @@ -0,0 +1,27 @@
>> +* Broadcom Dallas One wire (D1W) bus master controller
>> +
>> +Required properties:
>> +- compatible : should be "brcm,iproc-d1w"
>> +- reg : Address and length of the register set for the device
>> +- interrupts : IRQ number of D1W controller
>> +
>> +Optional properties:
>> +- clocks : phandle of clock that supplies the module (required if platform
>> +               clock bindings use device tree)
>> +- clock-names : name for the clock
>> +- clock-frequency : D1W divisor clock rate
> This should be bus-frequency. We messed up on I2C.
>
>> +- reset-recover-delay : Delay while reset D1W in milliseconds.
> Is this a standard 1-wire bus operation? I'm guessing so, but if not
> needs a vendor prefix.
>
> Also, needs unit suffix as defined in property-units.txt.
>
>> +
>> +Example:
>> +
>> +- From bcm-cygnus.dtsi:
>> +iproc_d1w: d1w at 180ab000 {
> Should be a generic name. So far in bindings/w1/ we have 3 different
> ones in 3 bindings. Lets go with "onewire".
>
>> +       compatible = "brcm,iproc_d1w";
> Doesn't match the doc.
We have some cleanup work to do.  Need to move to mfd and address your 
comments.
>
>> +       reg = <0x180ab000 0x0f>;
>> +       interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
>> +       clocks = <&axi81_clk>;
>> +       clock-names = "iproc_d1w_clk";
>> +       clock-frequency = <100000000>;
>> +       reset-recover-delay = <1>;
>> +};
>> +
>> --
>> 2.5.0
>>
