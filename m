From: richard.genoud@gmail.com (Richard Genoud)
Date: Wed, 10 Jul 2013 11:48:27 +0200
Subject: [PATCH v4 3/7] Documentation: DT: update atmel SSC with DMA
 binding
In-Reply-To: <20130709150543.GE27646@sirena.org.uk>
References: <1373372929-17800-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-4-git-send-email-richard.genoud@gmail.com>
 <20130709150543.GE27646@sirena.org.uk>
Message-ID: <CACQ1gAhK2yN2uhewq8XGOidLCDfOhgRvzE1o0b1krK1DjYj-dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/9 Mark Brown <broonie@kernel.org>:
> On Tue, Jul 09, 2013 at 04:25:29PM +0200, Richard Genoud wrote:
>
>>  - reg: Should contain SSC registers location and length
>>  - interrupts: Should contain SSC interrupt
>> +For dma transfer:
>> +- dmas: DMA specifier, consisting of a phandle to DMA controller node,
>> +  the memory interface and SSC DMA channel ID (for tx and rx).
>> +  See Documentation/devicetree/bindings/dma/atmel-dma.txt for details.
>> +- dma-names: Must be "tx", "rx".
>
> This is added as a required property so...
>
>> -Example:
>> +Examples:
>>  ssc0: ssc at fffbc000 {
>>       compatible = "atmel,at91rm9200-ssc";
>>       reg = <0xfffbc000 0x4000>;
>>       interrupts = <14 4 5>;
>>  };
>
> ...this first example is now invalid and should probably just be being
> extended with the new required properties.

Well, I have to rewrite that to make it clearer.
The thing is:
with "atmel,at91rm9200-ssc" the SSC doesn't work with DMA.
with "atmel,at91sam9g45-ssc", the SSC work ONLY with DMA.

So the dmas/dma-names properties are only required for g45-ssc, and
useless for rm9200-ssc

Maybe the best will be to write a paragraph for g45-ssc and another
for rm9200-ssc, even if there's some identical lines between them.


Thanks !

Richard.
