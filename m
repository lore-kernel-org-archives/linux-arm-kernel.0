From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Mon, 26 Mar 2018 13:27:05 +0200
Subject: [PATCH 4/7] ARM: dts: sun7i: Add pinmux settings for LCD0 RGB888
 output.
In-Reply-To: <20180326100114.fa7vjw342ad6vrb6@flea>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-4-git-send-email-giulio.benetti@micronovasrl.com>
 <1521986953.5301.4.camel@paulk.fr> <20180326100114.fa7vjw342ad6vrb6@flea>
Message-ID: <e3e51afb-bb32-7f2f-877e-b6c74d71ab06@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Il 26/03/2018 12:01, Maxime Ripard ha scritto:
> Hi,
> 
> On Sun, Mar 25, 2018 at 04:09:13PM +0200, Paul Kocialkowski wrote:
>> Le mercredi 21 mars 2018 ? 21:03 +0100, Giulio Benetti a ?crit :
>>> The A20 supports RGB888 with H/V sync from LCD0. Add a pinmux setting
>>> for the needed pins.
>>>
>>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>> ---
>>>   arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi
>>> b/arch/arm/boot/dts/sun7i-a20.dtsi
>>> index efb5607..bfe6728 100644
>>> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
>>> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
>>> @@ -922,6 +922,14 @@
>>>   				pins = "PI20", "PI21";
>>>   				function = "uart7";
>>>   			};
>>> +
>>> +			lcd0_rgb888_pins: lcd0-rgb888-pins {
>>
>> It would be more consistent with other pins definitions to have
>> underscores in both names and to indicate the index, such as:
>> lcd0_rgb888_pins: lcd0_rgb888_pins at 0 {
> 
> Both your suggestions will generate DTC warnings, and we'd like to get
> rid of them eventually :)
> 
>> This way, other set of pins for LCD (PH0-PH27) can be declared as @1
>> when they are needed in the future.
> 
> A better idea would be to call it lcd0-rgb888-pd-pins, and introduce
> the ph variant when it's done.

As I know, only PD is muxed with LCD0.
And PH is for LCD1 only.

And LCD0 seems to come out only from PD port according to datasheet,
this is why I didn't put @0 after lcd0-rgb888-pins.

So I don't think it makes sense to handle pins in the way Paul suggests.

What do you all think?

Giulio

> 
> Maxime
> 
> 
> 


-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ? 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
