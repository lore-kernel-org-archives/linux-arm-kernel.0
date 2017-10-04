From: joel@jms.id.au (Joel Stanley)
Date: Wed, 4 Oct 2017 15:30:10 +0930
Subject: [PATCH 8/8] ARM: dts: aspeed: Clean up UART nodes
In-Reply-To: <1507094931.5452.20.camel@aj.id.au>
References: <20170928075149.8154-1-joel@jms.id.au>
 <20170928075149.8154-9-joel@jms.id.au>
 <1507094931.5452.20.camel@aj.id.au>
Message-ID: <CACPK8Xe6eftZvZzuXChUr3+Nd+Hj5nDB723d-9QwrMszxto6-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 2:58 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> On Thu, 2017-09-28 at 17:21 +0930, Joel Stanley wrote:

>> -                     uart6: serial at 1e787000 {
>> -                             compatible = "ns16550a";
>> -                             reg = <0x1e787000 0x1000>;
>> +                     vuart: vuart at 1e787000 {
>
> Bit of a nit, but arguably this should be `vuart: serial at ...`?

Yep, that makes sense.

>
>> +                             compatible = "aspeed,ast2400-vuart";
>> +                             reg = <0x1e787000 0x40>;
>>                               reg-shift = <2>;
>>                               interrupts = <10>;
>>                               clocks = <&clk_uart>;
>> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
>> index 251fc9f4637e..0b793305120a 100644
>> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
>> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi

>> @@ -287,9 +278,19 @@
>>                               };
>>                       };
>>
>> +                     uart1: serial at 1e783000 {
>
> Earlier in the series you had a patch moving the ADC node to be in
> address-order with respect to the rest of the nodes but this change puts uart1
> out of address-order. As it turns out the uarts blocks are sprayed around in
> the address-space: uart1 and uart5 are together, the vuart is elsewhere, then
> uarts 2-4 are lumped together in another spot. I think it makes sense to
> consolidate them, but it is inconsistent. Thoughts?

Yeah. I'll move them to where they should be.

Cheers,

Joel
