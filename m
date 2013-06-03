From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 3 Jun 2013 14:55:27 +0200
Subject: [PATCH 1/2] ARM: dts: OMAP5: add PWM capability to timer nodes
 missing it
In-Reply-To: <37C860A02101E749A747FA2D3C1E3C504BE487@DLEE11.ent.ti.com>
References: <1366240995-53538-1-git-send-email-s-anna@ti.com>
 <516F3696.9080008@ti.com>
 <37C860A02101E749A747FA2D3C1E3C504BE487@DLEE11.ent.ti.com>
Message-ID: <51AC923F.2010607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On 06/01/2013 12:17 AM, Anna, Suman wrote:
> Benoit, Tony,
>  
>> On 04/17/2013 06:23 PM, Suman Anna wrote:
>>> OMAP5 has 6 timers (GPTimers 5, 6, 8 to 11) that are capable of PWM.
>>> The PWM capability property is missing from the node definitions of
>>> couple of timers, and this has been fixed.
>>>
>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>> ---
>>>  arch/arm/boot/dts/omap5.dtsi | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>>> index 790bb2a..0d155f5 100644
>>> --- a/arch/arm/boot/dts/omap5.dtsi
>>> +++ b/arch/arm/boot/dts/omap5.dtsi
>>> @@ -422,6 +422,7 @@
>>>  			interrupts = <0 41 0x4>;
>>>  			ti,hwmods = "timer5";
>>>  			ti,timer-dsp;
>>> +			ti,timer-pwm;
>>>  		};
>>>
>>>  		timer6: timer at 4013a000 {
>>> @@ -458,6 +459,7 @@
>>>  			reg = <0x4803e000 0x80>;
>>>  			interrupts = <0 45 0x4>;
>>>  			ti,hwmods = "timer9";
>>> +			ti,timer-pwm;
>>>  		};
>>>
>>>  		timer10: timer at 48086000 {
>>> @@ -465,6 +467,7 @@
>>>  			reg = <0x48086000 0x80>;
>>>  			interrupts = <0 46 0x4>;
>>>  			ti,hwmods = "timer10";
>>> +			ti,timer-pwm;
>>>  		};
>>>
>>>  		timer11: timer at 48088000 {
>>
>> Make sure you copy the linux-arm and device-tree mailing lists.
>>
>> Acked-by: Jon Hunter <jon-hunter@ti.com>
>>
> 
> Can you include this patch in your next fixes pull request (if you haven't
> already done so)? The other patch in the series is a feature change, but
> this is a fix, and can go into 3.10 itself.

I've just sent a pull request with two fixes to Tony. Since -rc4 is
already there, I'll update it with this fix.

Tony,

I will resend a new pull-request rebased on -rc4 that will include this
new fix.

Regards,
Benoit
