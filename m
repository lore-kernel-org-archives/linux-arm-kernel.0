From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Jul 2014 15:50:56 +0200
Subject: [PATCH] ARM: at91: at91sam9x5: correct typo error for ohci clock
In-Reply-To: <20140714081421.5f539287@bbrezillon>
References: <1405307294-17708-1-git-send-email-voice.shen@atmel.com>
 <20140714081421.5f539287@bbrezillon>
Message-ID: <53C92640.1000609@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/07/2014 08:14, Boris BREZILLON :
> On Mon, 14 Jul 2014 11:08:14 +0800
> Bo Shen <voice.shen@atmel.com> wrote:
> 
>> Correct the typo error for the second "uhphs_clk".
>>
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> 
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> sam9n12 dtsi has the same bug, I'll fix it

Ok, thanks to Voice and you: I try to queue them for 3.16-fixes.

Bye,

> And sorry for the mess when moving sam9n12 and sam9x5 to the CCF, I
> should have checked my clock definitions more carefully :-(.

I admit that these values are pretty hard to read: the eye get bored
quite quickly ;-)

Bye,


>> ---
>>  arch/arm/boot/dts/at91sam9x5.dtsi | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
>> index 2ebc421..727d3a4 100644
>> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
>> @@ -1155,8 +1155,7 @@
>>  			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
>>  			reg = <0x00600000 0x100000>;
>>  			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
>> -			clocks = <&usb>, <&uhphs_clk>, <&udphs_clk>,
>> -				 <&uhpck>;
>> +			clocks = <&usb>, <&uhphs_clk>, <&uhphs_clk>, <&uhpck>;
>>  			clock-names = "usb_clk", "ohci_clk", "hclk", "uhpck";
>>  			status = "disabled";
>>  		};
> 
> 
> 


-- 
Nicolas Ferre
