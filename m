From: caesar.upstream@gmail.com (Caesar Wang)
Date: Thu, 22 Oct 2015 11:55:25 +0800
Subject: [RESEND PATCH v2 1/2] dt-bindings: rockchip-thermal: Add the
 "init" pinctrl in this document
In-Reply-To: <CAD=FV=XdN_Lie9bjbr0M4-=neVGrLiahAAxyUEuE0kO2ZsusfQ@mail.gmail.com>
References: <1445481048-20789-1-git-send-email-wxt@rock-chips.com>
 <1445481048-20789-2-git-send-email-wxt@rock-chips.com>
 <CAD=FV=XdN_Lie9bjbr0M4-=neVGrLiahAAxyUEuE0kO2ZsusfQ@mail.gmail.com>
Message-ID: <56285E2D.2040707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015?10?22? 11:45, Doug Anderson ??:
> Caesar,
>
> On Wed, Oct 21, 2015 at 7:30 PM, Caesar Wang <wxt@rock-chips.com> wrote:
>> The "init" pinctrl is defined we'll set
>> pinctrl to this state before probe and then "default" after probe.
>>
>> Add the "init" pinctrl as the OTP gpio state, since we need switch
>> the pin to gpio state before the TSADC controller is reset.
>>
>> As I know, the TSADC controller is reset, the tshut polarity will be
>> a *low* signal in a short period of time for some devices.
>>
>> Says:
>> The TSADC get the temperature on rockchip thermal.
>>
>> If T(current temperature) < (setting temperature), the OTP output the
>> *high* signal.
>> If T(current temperature) > (setting temperature), the OTP output the
>> *low* Signal.
>>
>> In some cases, the OTP pin is connected to the PMIC, maybe the
>> PMIC can accept the reset response time to avoid this issue.
>>
>> In other words, the system will be always reboot if we make the
>> OTP pin is connected the others IC to control the power.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>> Changes in v2:
>>    - Add the 'init' pinctrl more decription in commit.
>>    - Fix the subject to make more obvious in PATCH[1/2]
>>    - Resend this patch v2 since fix the subject to be specific.
>>
>> Changes in v1:
>>    - As the Doug comments, add the 'init' property to sync document.
>>
>>   Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> index ef802de..28e84f7 100644
>> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> I think Rob wanted something more in the "rockchip-thermal.txt"
> document itself.  Like:
>
> Pinctrl states:
> - During device probe a driver may glitch the output line.  If this is
> not acceptable for your board, you can use the standard "init" and
> "default" pinctrl states.  The "init" state will be set before device
> probe and "default" after.

Sound resonable.
Thanks Doug to explain!

>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
Thanks,
Caesar
