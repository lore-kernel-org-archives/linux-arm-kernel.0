From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 19 Apr 2017 23:49:30 +0800
Subject: [linux-sunxi] Re: [PATCH 2/4] ARM: sunxi: Drop
 mmc0_cd_pin_reference_design pinmux setting
In-Reply-To: <442479d213a83c73cd7ff44538d234ea@aosc.io>
References: <20170419050919.6762-1-wens@csie.org>
 <20170419050919.6762-3-wens@csie.org>
 <442479d213a83c73cd7ff44538d234ea@aosc.io>
Message-ID: <CAGb2v66jgUYHWzdhysznst6jPF=jtTVw3jZ7x3qh1X36FPPp1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 11:36 PM,  <icenowy@aosc.io> wrote:
> ? 2017-04-19 13:09?Chen-Yu Tsai ???
>>
>> As part of our effort to move pinctrl/GPIO interlocking into the
>> driver where it belongs, this patch drops the definition and usage
>> of the mmc0_cd_pin_reference_design pinmux setting for the default
>> mmc0 card detect GPIO pin.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

[...]

>> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi
>> b/arch/arm/boot/dts/sun7i-a20.dtsi
>> index 93aa55970bd7..c03b59aaec82 100644
>> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
>> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
>> @@ -1190,12 +1190,6 @@
>>                                 bias-pull-up;
>>                         };
>>
>> -                       mmc0_cd_pin_reference_design: mmc0_cd_pin at 0 {
>> -                               pins = "PH1";
>> -                               function = "gpio_in";
>> -                               bias-pull-up;
>
>
> It needs pull up, so shouldn't be dropped.
>
> (Although there may be external pull-up resistors on the board;
> however last time we removed the pull-up on MMC node many boards
> failed, so we cannot rely on external pull-up resistors)

I checked the boards that I have schematics, and the reference design.
All have proper external pull-up resistors for this pin, unlike the
other mmc pins.

If some board doesn't, it really needs to be singled out and handled
separately. Have you encountered any issues?

Regards
ChenYu

>
>> -                       };
>> -
>>                         mmc2_pins_a: mmc2 at 0 {
>>                                 pins = "PC6", "PC7", "PC8",
>>                                        "PC9", "PC10", "PC11";
>
>
> --
> You received this message because you are subscribed to the Google Groups
> "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
