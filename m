From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 9 Jul 2013 15:20:38 +0200
Subject: [PATCH v3 3/7] Documentation: DT: update atmel SSC with DMA
 binding
In-Reply-To: <CACQ1gAg8WQTaz4XkXJCH+-bNU_U3s_1pgmQYoQR3v-KHOzzBTA@mail.gmail.com>
References: <1373290193-25300-1-git-send-email-richard.genoud@gmail.com>
 <1373372929-17800-1-git-send-email-richard.genoud@gmail.com>
 <1373372929-17800-4-git-send-email-richard.genoud@gmail.com>
 <CACQ1gAg8WQTaz4XkXJCH+-bNU_U3s_1pgmQYoQR3v-KHOzzBTA@mail.gmail.com>
Message-ID: <51DC0E26.7080508@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2013 15:19, Richard Genoud :
> 2013/7/9 Richard Genoud <richard.genoud@gmail.com>:
>> As atmel-ssc can be used with DMA, the documentation should be updated.
>> Also, a configuration DMA example is given.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> ---
>>   .../devicetree/bindings/misc/atmel-ssc.txt         |   24 ++++++++++++++++++--
>>   1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/misc/atmel-ssc.txt b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
>> index 38e51ad..96958ca 100644
>> --- a/Documentation/devicetree/bindings/misc/atmel-ssc.txt
>> +++ b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
>> @@ -6,10 +6,30 @@ Required properties:
>>          - atmel,at91sam9g45-ssc: support dma transfer
>>   - reg: Should contain SSC registers location and length
>>   - interrupts: Should contain SSC interrupt
>> +For dma transfer:
>> +- dmas: DMA specifier, consisting of a phandle to DMA controller node,
>> +  the memory interface and SSC DMA channel ID (for tx and rx).
>> +  See Documentation/devicetree/bindings/dma/atmel-dma.txt for details.
>> +- dma-names: Must be "tx", "rx".
>>
>> -Example:
>> +
>> +Examples:
>>   ssc0: ssc at fffbc000 {
>>          compatible = "atmel,at91rm9200-ssc";
>>          reg = <0xfffbc000 0x4000>;
>> -       interrupts = <14 4 5>;
>> +       interrupts = <14 IRQ_TYPE_LEVEL_HIGH 5>;
> maybe I should not use macro in the documentation (not sure if I should or not).

absolutely.

>>   };
>> +
>> +
>> +ssc0: ssc at f0010000 {
>> +      compatible = "atmel,at91sam9g45-ssc";
>> +      reg = <0xf0010000 0x4000>;
>> +      interrupts = <28 IRQ_TYPE_LEVEL_HIGH 5>;
>> +      dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(13)>,
>> +            <&dma0 1 AT91_DMA_CFG_PER_ID(14)>;
> same here
>> +      dma-names = "tx", "rx";
>> +      pinctrl-names = "default";
>> +      pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
>> +      status = "disabled";
>> +};
>> +
>> --
>> 1.7.10.4
>>
>
>
>


-- 
Nicolas Ferre
