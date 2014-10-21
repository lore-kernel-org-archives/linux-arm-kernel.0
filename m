From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 21 Oct 2014 18:32:19 +0200
Subject: [PATCH] ARM: at91/dt: sam9263: fix PLLB frequencies
In-Reply-To: <20141010160148.57290e20@bbrezillon>
References: <1412949021-15150-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20141010160148.57290e20@bbrezillon>
Message-ID: <54468A93.6080707@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2014 16:01, Boris Brezillon :
> On Fri, 10 Oct 2014 15:50:21 +0200
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> 
>> From: Boris Brezillon <boris.brezillon@free-electrons.com>
>>
>> PLLB input and output ranges were wrongly copied from at91sam9261 as the
>> datasheet didn't mention explicitly PLLB. Correct their values.
>>
>> This fixes USB.
>>
>> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Thanks for sending this patch.
> 
> Just adding Andreas in Cc and adding his Reported and Tested-by.
> 
> Reported-by: Andreas Henriksson <andreas.henriksson@endian.se>
> Tested-by: Andreas Henriksson <andreas.henriksson@endian.se>

Added to the tag area of the patch and stacked on at91-3.18-fixes branch.

Thanks!

> 
>> ---
>>  arch/arm/boot/dts/at91sam9263.dtsi | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
>> index d68b3c4862bc..51416c7d0625 100644
>> --- a/arch/arm/boot/dts/at91sam9263.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9263.dtsi
>> @@ -122,9 +122,10 @@
>>  					interrupts-extended = <&pmc AT91_PMC_LOCKB>;
>>  					clocks = <&main>;
>>  					reg = <1>;
>> -					atmel,clk-input-range = <1000000 5000000>;
>> +					atmel,clk-input-range = <1000000 32000000>;
>>  					#atmel,pll-clk-output-range-cells = <4>;
>> -					atmel,pll-clk-output-ranges = <70000000 130000000 1 1>;
>> +					atmel,pll-clk-output-ranges = <80000000 200000000 0 1>,
>> +								<190000000 240000000 2 1>;
>>  				};
>>  
>>  				mck: masterck {
> 
> 
> 


-- 
Nicolas Ferre
