From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 4 Nov 2016 16:12:11 +0800
Subject: [PATCH v2 13/14] ARM: dts: sun6i: hummingbird: Enable internal
 audio codec
In-Reply-To: <20161103084543.m4zvwhscpaa3y5ay@lukather>
References: <20161103075556.29018-1-wens@csie.org>
 <20161103075556.29018-14-wens@csie.org>
 <20161103084543.m4zvwhscpaa3y5ay@lukather>
Message-ID: <CAGb2v67N3G8+MC4iKFSg=fumLVv9hnswPXLEfBGHvADdVbdAGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 3, 2016 at 4:45 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Nov 03, 2016 at 03:55:55PM +0800, Chen-Yu Tsai wrote:
>> The Hummingbird A31 has headset and line in audio jacks and an onboard
>> mic routed to the pins for the SoC's internal codec. The line out pins
>> are routed to an onboard speaker amp, whose output is available on a
>> pin header.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
>> index 9a74637f677f..48c041b75aab 100644
>> --- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
>> +++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
>> @@ -69,6 +69,19 @@
>>       };
>>  };
>>
>> +&codec {
>> +     allwinner,audio-routing =
>> +             "Headphone", "HP",
>> +             "Speaker", "LINEOUT",
>> +             "LINEIN", "Line In",
>> +             "MIC1", "Mic",
>> +             "MIC2", "Headset Mic",
>> +             "Mic",  "MBIAS",
>> +             "Headset Mic", "HBIAS";
>> +     allwinner,pa-gpios = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
>> +     status = "okay";
>> +};
>> +
>>  &cpu0 {
>>       cpu-supply = <&reg_dcdc3>;
>>  };
>> @@ -152,6 +165,13 @@
>>  };
>>
>>  &pio {
>> +     codec_pa_pin: codec_pa_pin at 0 {
>> +             allwinner,pins = "PH22";
>> +             allwinner,function = "gpio_out";
>> +             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +     };
>> +
>
> This pin group isn't used anywhere. Because of the strict thing in
> pinctrl, I'd say it's better to not set it, but then, the pin group is
> useless.

I'll drop the pinmux setting then.

ChenYu
