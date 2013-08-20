From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 20 Aug 2013 18:59:47 +0200
Subject: [PATCH 1/1] ARM: at91: at91sam9260: add missing pinctrl-names
 on mmc
In-Reply-To: <20130820162442.GF5149@ludovic.desroches@atmel.com>
References: <1373882719-9940-1-git-send-email-plagnioj@jcrosoft.com>
 <520B353F.9070605@atmel.com>
 <20130820162442.GF5149@ludovic.desroches@atmel.com>
Message-ID: <5213A083.6010005@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/08/2013 18:24, Ludovic Desroches :
> On Wed, Aug 14, 2013 at 09:43:59AM +0200, Nicolas Ferre wrote:
>> On 15/07/2013 12:05, Jean-Christophe PLAGNIOL-VILLARD :
>>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>>> ---
>>>   arch/arm/boot/dts/at91sam9260.dtsi | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
>>> index c7ccbcb..56ee828 100644
>>> --- a/arch/arm/boot/dts/at91sam9260.dtsi
>>> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
>>> @@ -572,6 +572,7 @@
>>>   				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 0>;
>>>   				#address-cells = <1>;
>>>   				#size-cells = <0>;
>>> +				pinctrl-names = "default";
>>
>> Ok, but there is no pinctrl property in this node: maybe it would be
>> good to have a default entry for this.
>>
>> It is then overloaded in arch/arm/boot/dts/animeo_ip.dts for instance...
>>
>
> Yes it is overloaded in arch/arm/boot/dts/at91sam9g20ek_common.dtsi.
>
> mmc0 pinctrl configuration is set in at91sam9260.dtsi that is ok but do we have
> to put a minimal pinctrl property as the mmc clock pinctrl? It is board
> relative and no device related.

Well, I think that the minimal set of IOs to do some MMC/SD transfers is 
device related. You can choose the clock, command and DAT0 lines that a 
particular product is using for a certain MCI instance. Even if the IOs 
are changing on the board (i suspect none of our AT91 chips have several 
multiplexing options for MCI), you can still overload them in the board 
.dtsi/.dts file. It is certainly useful for adding DAT1-DAT3 for example.

Looking at the other peripherals, I see that we are very often doing 
this kind of pinctrl declaration scheme.

> So maybe it is not the right place then I am
> wondering if pinctrl-names should be set in at91sam9260.dtsi...

It seems to be the right place in addition to a pinctrl-0 property 
setting a ... default set of pins.

>> Can you please add one?

Ludovic, I let you take over the addition of such a
pinctrl-names/pinctrl-0 set of properties to this node.

Bye,

>>
>> Bye,
>>
>>>   				status = "disabled";
>>>   			};
>>>
>>>
>>
>>
>> --
>> Nicolas Ferre
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>


-- 
Nicolas Ferre
