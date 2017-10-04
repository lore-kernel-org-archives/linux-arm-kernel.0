From: joel@jms.id.au (Joel Stanley)
Date: Wed, 4 Oct 2017 14:43:15 +0930
Subject: [PATCH 2/8] ARM: dts: aspeed: Reorder ADC node
In-Reply-To: <1507088159.5452.3.camel@aj.id.au>
References: <20170928075149.8154-1-joel@jms.id.au>
 <20170928075149.8154-3-joel@jms.id.au>
 <1507088159.5452.3.camel@aj.id.au>
Message-ID: <CACPK8XfENyKdcV1ZgPrf-Kv+H5BsyQcaCX9ha_gNgD3gcuBUwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 1:05 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> On Thu, 2017-09-28 at 17:21 +0930, Joel Stanley wrote:
>> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
>> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
>> @@ -129,6 +129,14 @@
>>                               };
>>                       };
>>
>> +                     adc: adc at 1e6e9000 {
>> +                             compatible = "aspeed,ast2400-adc";
>> +                             reg = <0x1e6e9000 0xb0>;
>> +                             clocks = <&syscon ASPEED_CLK_APB>;
>
> We can't do this yet as the clk driver isn't yet merged, and it breaks from the
> "just move the node" description in the commit message.

Yep. This was a bad commit that comes from post-clk driver. I will fix in v2.

>> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
>> index f56dd67efa50..f6430b313f90 100644
>> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
>> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
>> @@ -173,6 +173,14 @@
>>                               reg-io-width = <4>;
>>                       };
>>
>> +                     adc: adc at 1e6e9000 {
>> +                             compatible = "aspeed,ast2500-adc";
>> +                             reg = <0x1e6e9000 0xb0>;
>
> Did you intend to change the size cell value here? It now matches the g4, but
> there was an explicit comment about the size for some reason in the -hunk
> below. It's probably worth an explicit call-out if we're going to change it.

Looks ok to me.

Thanks for the review.

Cheers,

Joel
