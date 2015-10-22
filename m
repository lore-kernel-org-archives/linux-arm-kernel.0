From: caesar.upstream@gmail.com (Caesar Wang)
Date: Thu, 22 Oct 2015 09:46:55 +0800
Subject: [PATCH v2 1/2] dt-bindings: Add the "init" pinctrl in this
 document
In-Reply-To: <CAL_JsqJHov0AcwHprU8wtjH4uX5QBYKsCVVsDqhEy9vSMGZPYQ@mail.gmail.com>
References: <1445477130-17065-1-git-send-email-wxt@rock-chips.com>
 <1445477130-17065-2-git-send-email-wxt@rock-chips.com>
 <CAL_JsqJHov0AcwHprU8wtjH4uX5QBYKsCVVsDqhEy9vSMGZPYQ@mail.gmail.com>
Message-ID: <5628400F.4000901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015?10?22? 09:34, Rob Herring ??:
> On Wed, Oct 21, 2015 at 8:25 PM, Caesar Wang <wxt@rock-chips.com> wrote:
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
>>    - As the Rob comments, add the 'init' pinctrl more decription in document.
> Where?

Okay,  Mr, Rob
That strictly speaking only in commit.:-(


>
>>    - fix the subject to make more obvious in PATCH[1/2]
>> Series-changes: 1
>>    - As the Doug comments, add the 'init' property to sync document.
>>
>> Changes in v1: None
>>
>>   Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> index ef802de..28e84f7 100644
>> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> @@ -27,8 +27,9 @@ tsadc: tsadc at ff280000 {
>>          clock-names = "tsadc", "apb_pclk";
>>          resets = <&cru SRST_TSADC>;
>>          reset-names = "tsadc-apb";
>> -       pinctrl-names = "default";
>> -       pinctrl-0 = <&otp_out>;
>> +       pinctrl-names = "init", "default";
>> +       pinctrl-0 = <&otp_gpio>;
>> +       pinctrl-1 = <&otp_out>;
>>          #thermal-sensor-cells = <1>;
>>          rockchip,hw-tshut-temp = <95000>;
>>          rockchip,hw-tshut-mode = <0>;
>> --
>> 1.9.1
>>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
Thanks,
Caesar
