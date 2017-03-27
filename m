From: zhang.lyra@gmail.com (Chunyan Zhang)
Date: Mon, 27 Mar 2017 14:23:59 +0800
Subject: [PATCH V4 3/4] dt-bindings: serial: add a new compatible string
 for SC9860
In-Reply-To: <20170324023657.2iyh22lr52rme5bu@rob-hp-laptop>
References: <1489729898-774-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1489729898-774-4-git-send-email-chunyan.zhang@spreadtrum.com>
 <20170324023657.2iyh22lr52rme5bu@rob-hp-laptop>
Message-ID: <CAAfSe-tF=tUV8r00aXz_69H4xhj=kyZDF_BbezhQS7L3LyTriQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 24 March 2017 at 10:36, Rob Herring <robh@kernel.org> wrote:
> On Fri, Mar 17, 2017 at 01:51:37PM +0800, Chunyan Zhang wrote:
>> SC9860 use the same serial device which SC9836 uses, so added a new
>> compatible string to support SC9860 as well, also added an example
>> of how to describe this serial device in DT.
>>
>> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>> ---
>>  Documentation/devicetree/bindings/serial/sprd-uart.txt | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
>> index 2aff0f2..1db5d6f 100644
>> --- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
>> +++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
>> @@ -1,7 +1,19 @@
>>  * Spreadtrum serial UART
>>
>>  Required properties:
>> -- compatible: must be "sprd,sc9836-uart"
>> +- compatible: must be one of:
>> +  * "sprd,sc9836-uart"
>> +  * "sprd,sc9860-uart", "sprd,sc9836-uart"
>> +
>>  - reg: offset and length of the register set for the device
>>  - interrupts: exactly one interrupt specifier
>>  - clocks: phandles to input clocks.
>> +
>> +Example:
>> +     uart0: serial at 000000 {
>
> serial at 0
>

Addressed this.

> With that,
>
> Acked-by: Rob Herring <robh@kernel.org>

Thanks for your review,
Chunyan

>
>
>> +             compatible = "sprd,sc9860-uart",
>> +                          "sprd,sc9836-uart";
>> +             reg = <0x000000 0x100>;
>> +             interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
>> +             clocks = <&ext_26m>;
>> +     };
>> --
>> 2.7.4
>>
