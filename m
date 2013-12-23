From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Dec 2013 00:50:33 +0800
Subject: [PATCH 4/4] ARM: dts: sun7i: Add pin muxing options for clock
 outputs
In-Reply-To: <52B8685C.3060001@elopez.com.ar>
References: <1387787827-11341-1-git-send-email-wens@csie.org>
 <1387787827-11341-5-git-send-email-wens@csie.org>
 <52B8685C.3060001@elopez.com.ar>
Message-ID: <CAGb2v66odQrh=mDPX8z0iZCXRKV=1ZNuURxua80e-Tdz8KxzWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 24, 2013 at 12:44 AM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> Hi,
>
> El 23/12/13 05:37, Chen-Yu Tsai escribi?:
>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>
>
> Other than the lack of a commit description, the patch looks ok to me.

I'll try to add something meaningful. Might be the same as patch 3 for pinctrl
though.

>
>
>>   arch/arm/boot/dts/sun7i-a20.dtsi | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi
>> b/arch/arm/boot/dts/sun7i-a20.dtsi
>> index 6ad5507..d6e7251 100644
>> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
>> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
>> @@ -414,6 +414,20 @@
>>                                 allwinner,drive = <0>;
>>                                 allwinner,pull = <0>;
>>                         };
>> +
>> +                       clk_out_a_pins: clk_out_a {
>
>
> I see the other nodes all start like
>
>         foo_pins_a: foo0 at 0 {
>
> Maybe yours should too? Maxime, thoughts?

I suppose this makes sense if we wanted multiple pinctrl states
for the same device?

>
>
>> +                               allwinner,pins = "PI12";
>> +                               allwinner,function = "clk_out_a";
>> +                               allwinner,drive = <0>;
>> +                               allwinner,pull = <0>;
>> +                       };
>> +
>> +                       clk_out_b_pins: clk_out_b {
>> +                               allwinner,pins = "PI13";
>> +                               allwinner,function = "clk_out_b";
>> +                               allwinner,drive = <0>;
>> +                               allwinner,pull = <0>;
>> +                       };
>>                 };
>>
>>                 timer at 01c20c00 {
>>
>
> Thanks for working on this!
>
> Emilio
