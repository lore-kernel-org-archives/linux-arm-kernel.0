From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 19 Sep 2015 17:39:23 -0400
Subject: [linux-sunxi] [PATCH 3/4] ARM: dts: sun8i: Enable PWM controller
 on A23/A33 Q8 format tablets
In-Reply-To: <CAGb2v65kEqxiWLz_faQzMWFP0nHY_tv-aJCZGNQJjYFbGEn8rQ@mail.gmail.com>
References: <1442561739-6824-1-git-send-email-wens@csie.org>
 <1442561739-6824-4-git-send-email-wens@csie.org>
 <55FC2E95.7040006@redhat.com>
 <CAGb2v65kEqxiWLz_faQzMWFP0nHY_tv-aJCZGNQJjYFbGEn8rQ@mail.gmail.com>
Message-ID: <55FDD60B.7080204@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/18/2015 12:25 PM, Chen-Yu Tsai wrote:
> On Fri, Sep 18, 2015 at 11:32 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 09/18/2015 03:35 AM, Chen-Yu Tsai wrote:
>>>
>>> A23/A33 based Q8 format tablets use channel 0 of the PWM controller for
>>> backlight dimming.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>    arch/arm/boot/dts/sun8i-q8-common.dtsi | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/sun8i-q8-common.dtsi
>>> b/arch/arm/boot/dts/sun8i-q8-common.dtsi
>>> index 6f8a8bb4e9bb..4c2d0b459d6f 100644
>>> --- a/arch/arm/boot/dts/sun8i-q8-common.dtsi
>>> +++ b/arch/arm/boot/dts/sun8i-q8-common.dtsi
>>> @@ -70,6 +70,12 @@
>>>          };
>>>    };
>>>
>>> +&pwm {
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&pwm0_pins>;
>>> +       status = "okay";
>>> +};
>>> +
>>>    &r_uart {
>>>          pinctrl-names = "default";
>>>          pinctrl-0 = <&r_uart_pins_a>;
>>>
>>
>> I've a feeling this should be in sunxi-q8-common.dtsi not
>> sun8i-q8-common.dtsi, which requires adding a pwm
>> node to sun5i.dtsi I'll look into this.
>
> It probably should.

Which means the name of the pinctrl node should be the same
on both, hence my request to rename that. Anyways Maxime
has already merged that now, I'll workaround it and / or
do a followup patch.

> IIRC sun5i PWM has only one channel as opposed to
> 2 on A10/A20.

Nope sun5i has 2 channels, but the second channel is
only routed to the outside on A10s, not on A13.

Regards,

Hans
