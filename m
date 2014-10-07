From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 7 Oct 2014 09:54:05 +0200
Subject: [PATCH v3 1/1] ARM: at91/dt: sam9x5: Add CAN device nodes
In-Reply-To: <1553953.Bxvx42RTxh@ws-stein>
References: <1412605640-29472-1-git-send-email-alexander.stein@systec-electronic.com>
 <5432B637.1060200@atmel.com> <1553953.Bxvx42RTxh@ws-stein>
Message-ID: <54339C1D.5000501@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2014 17:57, Alexander Stein :
> Hi Jean,

s/Jean/Nicolas/

;-)

> On Monday 06 October 2014 17:33:11, Nicolas Ferre wrote:
>> On 06/10/2014 16:27, Alexander Stein :
>>> Add the missing CAN devices node including their pin muxing and clocks.
>>>
>>> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
>>> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>> ---
>>> Changes in v3:
>>> * Match the pin name to the ones in the datasheet.
>>>
>>>  arch/arm/boot/dts/at91sam9x5.dtsi | 48 +++++++++++++++++++++++++++++++++++++++
>>
>> Alexander,
>>
>> In fact, we already have a placeholder for these nodes:
>> arch/arm/boot/dts/at91sam9x5_can.dtsi
>>
>> The file is only included in SoC device trees which actually contain
>> this peripheral: at91sam9x25 and at91sam9x35 (and not the other variants
>> of this family).
> 
> Actually, I can't find anyone including this :-/ If they would I guess I should have hit an error for duplicated labels.
> Is this a mistake no-one includes at91sam9x5_can.dtsi?

Yes it is. It should be included in
arch/arm/boot/dts/at91sam9x[23]5.dtsi files.

>> So, can you please move this addition above into the
>> arch/arm/boot/dts/at91sam9x5_can.dtsi file?
> 
> Can you confirm that both (at91sam9x25 and at91sam9x35) have identical peripheral addresses, irq and pinmuxing?

Absolutely, the same.

Thanks, bye.
-- 
Nicolas Ferre
