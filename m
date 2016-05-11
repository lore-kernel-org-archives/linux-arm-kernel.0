From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 11 May 2016 17:14:07 +0200
Subject: [PATCH] ARM: dts: at91: sam9x5: Fix the memory range assigned to
 the PMC
In-Reply-To: <5733056C.9000100@atmel.com>
References: <1462957202-22671-1-git-send-email-boris.brezillon@free-electrons.com>
 <5733056C.9000100@atmel.com>
Message-ID: <57334C3F.5010605@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 11/05/2016 12:11, Nicolas Ferre a ?crit :
> Le 11/05/2016 11:00, Boris Brezillon a ?crit :
>> The memory range assigned to the PMC (Power Management Controller) was
>> not including the PMC_PCR register which are used to control peripheral
>> clocks.
>>
>> This was working fine thanks to the page granularity of ioremap(), but
>> started to fail when we switched to syscon/regmap, because regmap is
>> making sure that all accesses are falling into the reserved range.
>>
>> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>> Reported-by: Richard Genoud <richard.genoud@gmail.com>
>> Tested-by: Richard Genoud <richard.genoud@gmail.com>
>> Fixes: 863a81c3be1d ("clk: at91: make use of syscon to share PMC registers in several drivers")
>> Cc: <stable@vger.kernel.org>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Thanks Boris!
> 
> 
>> ---
>> Hi Arnd,
>>
>> This patch is fixing a regression reported by Richard. Since this
>> regression was introduced in 4.6-rc1 it would be great if you could
>> take it before 4.6 is released.
> 
> Arnd, arm-soc guys,
> 
> I can build a Pull-Request instantly today, if you wish: just tell me if
> you prefer.

Actually, I've just sent one so that we don't loose time:

"[GIT PULL] at91: fixes for 4.6 #2"

Bye,

>> ---
>>  arch/arm/boot/dts/at91sam9x5.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
>> index 0827d59..cd0cd5f 100644
>> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
>> @@ -106,7 +106,7 @@
>>  
>>  			pmc: pmc at fffffc00 {
>>  				compatible = "atmel,at91sam9x5-pmc", "syscon";
>> -				reg = <0xfffffc00 0x100>;
>> +				reg = <0xfffffc00 0x200>;
>>  				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
>>  				interrupt-controller;
>>  				#address-cells = <1>;
>>
> 
> 


-- 
Nicolas Ferre
