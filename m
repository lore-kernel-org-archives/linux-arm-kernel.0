From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 25 Mar 2015 17:02:42 +0200
Subject: [PATCHv5 27/35] ARM: dts: am33xx: add minimal l4 bus layout with
 control module support
In-Reply-To: <20150320233043.GW31346@atomide.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
 <1426877086-17131-28-git-send-email-t-kristo@ti.com>
 <550C9490.3070505@ti.com> <20150320223541.GV31346@atomide.com>
 <550CABD9.5060000@ti.com> <20150320233043.GW31346@atomide.com>
Message-ID: <5512CE12.6030301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2015 01:30 AM, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [150320 16:24]:
>> On 03/20/2015 05:35 PM, Tony Lindgren wrote:
>>> * Suman Anna <s-anna@ti.com> [150320 14:44]:
>>>> On 03/20/2015 01:44 PM, Kristo, Tero wrote:
>>>>> +			scm: scm at 210000 {
>>>>> +				compatible = "ti,am3-scm", "simple-bus";
>>>>> +				reg = <0x210000 0x2000>;
>>>>> +				#address-cells = <1>;
>>>>> +				#size-cells = <1>;
>>>>> +				ranges = <0 0x210000 0x2000>;
>>>>> +
>>>>> +				am33xx_pinmux: pinmux at 800 {
>>>>> +					compatible = "pinctrl-single";
>>>>> +					reg = <0x800 0x238>;
>>>>> +					#address-cells = <1>;
>>>>> +					#size-cells = <0>;
>>>>> +					pinctrl-single,register-width = <32>;
>>>>> +					pinctrl-single,function-mask = <0x7f>;
>>>>> +				};
>>>>> +
>>>>> +				scm_conf: scm_conf at 0 {
>>>>> +					compatible = "syscon";
>>>>> +					reg = <0x0 0x7fc>;
>>>>
>>>> Hmm, you are consolidating the am33xx_control_module and cm nodes, so is
>>>> this supposed to be 0x800 or 0x7fc? I would think it should be 0x800.
>>>
>>> Seems correct to me, it's offset 0, size 0x7fc. So that's the scm_conf
>>> syscon area before pinctrl-single at 0x44c00000 + 0x210000 + 0.
>>>
>>> The io area for pinctrl-single starts at 0x800, so the scm_conf should
>>> be before it in the dts file.
>>
>> Well, I understand that it is how it was before, but we won't be mapping
>> or covering the last register efuse_sma before the pinctrl cfg
>> registers. Any reason for just leaving out that register?
>
> Oh I see yeah that looks like a bug to me.
>
> Tony
>

Updated this patch in my branch now to make scm_conf area be size 0x800.

-Tero
