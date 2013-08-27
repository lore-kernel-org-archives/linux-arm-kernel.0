From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 26 Aug 2013 22:04:01 -0600
Subject: [PATCH 4/4] Documentation: Add device tree bindings for Freescale
 FTM PWM
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F827E61F2@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
 <1377054462-6283-5-git-send-email-Li.Xiubo@freescale.com>
 <1473340.OXSHEp7d4P@flatron>
 <1DD289F6464F0949A2FCA5AA6DC23F827D2244@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130822062610.GR31036@pengutronix.de> <20130823073612.GB3535@ulmo>
 <5217B807.7020800@wwwdotorg.org>
 <1DD289F6464F0949A2FCA5AA6DC23F827E11AC@039-SN2MPN1-012.039d.mgd.msft.net>
 <521BB40D.7040001@wwwdotorg.org>
 <1DD289F6464F0949A2FCA5AA6DC23F827E61F2@039-SN2MPN1-012.039d.mgd.msft.net>
Message-ID: <521C2531.10402@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/2013 09:48 PM, Xiubo Li-B47053 wrote:
> Hi Stephen,
> 
> 
>> Subject: Re: [PATCH 4/4] Documentation: Add device tree bindings for
>> Freescale FTM PWM
>>
>> On 08/25/2013 11:35 PM, Xiubo Li-B47053 wrote:
>>>> Subject: Re: [PATCH 4/4] Documentation: Add device tree bindings for
>> ...
>>>>> Why do you need to manipulate the pinctrl to en/disable a channel?
>>>>
>>>> This is because in Vybrid VF610 TOWER board, there are 4 leds, and
>>>> each led's one point(diode's positive pole) is connected to 3.3V, and
>>>> the other point is connected to pwm's one channel. When the 4
>>>> pinctrls are configured as enable at the same time, the 4 pinctrls is
>>>> low valtage, and the 4 leds will be lighted up as default, then when
>>>> you enable/disable one led will effects others.
>>>>
>>>> These pinctrls are belong to pwm, and I don't think led or other
>>>> customer could control them directly.
>>>> So, here I authorize the 4 pinctrls to each channel controls.
>>>>
>>> "
>>> For the reason above, I have to control the pinctrls separately.
>>>
>>> If all the pinctrls set as default state, the 8 pinctrls must be
>> controlled together.
>>> And the 4 leds will all be lighted up as default and will influence
>> each other.
>>
>> Sorry, that still doesn't make much sense. ...

What may help here is to show the exact content you expect the various
en/dis states to have, so that we can see exactly which pinctrl options
get set when and why.
