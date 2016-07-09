From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 9 Jul 2016 11:28:11 +0200
Subject: [PATCH 05/15] ARM: dts: sun5i: reference-design-tablet: Remove
 mention of q8
In-Reply-To: <CAGb2v67S9s5PifX4JOjp6DK57Q3aVRrKMdf7y75vna2rdrASFA@mail.gmail.com>
References: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
 <1467993956-19535-6-git-send-email-hdegoede@redhat.com>
 <CAGb2v67S9s5PifX4JOjp6DK57Q3aVRrKMdf7y75vna2rdrASFA@mail.gmail.com>
Message-ID: <c62ce392-f965-1f44-dd9b-1d784969803b@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09-07-16 05:53, Chen-Yu Tsai wrote:
> On Sat, Jul 9, 2016 at 12:05 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Remove all mention of q8 from sun5i-reference-design-tablet.dtsi.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
>> index e78452c..20cc940 100644
>> --- a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
>> +++ b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
>> @@ -98,7 +98,7 @@
>>
>>  &mmc0 {
>>         pinctrl-names = "default";
>> -       pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_q8>;
>> +       pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
>>         vmmc-supply = <&reg_vcc3v0>;
>>         bus-width = <4>;
>>         cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
>> @@ -118,7 +118,7 @@
>>                 allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>>         };
>>
>> -       mmc0_cd_pin_q8: mmc0_cd_pin at 0 {
>> +       mmc0_cd_pin: mmc0_cd_pin at 0 {
>
> We could name this mmc0_cd_pin_reference_design and put it in
> sun5i-a13.dtsi. We already do this for A10/A20.

I would prefer to keep this this way, I was never really fond
of the A10/A20 solution, in retrospect we should have done
a sun4i-a10-reference-design.dtsi defining a lot more stuff
then just the cd_pin.

> This works equally well though.
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Thanks.

Regards,

Hans


>
>>                 allwinner,pins = "PG0";
>>                 allwinner,function = "gpio_in";
>>                 allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> --
>> 2.7.4
>>
