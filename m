From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 7 Nov 2017 13:12:43 +0530
Subject: [PATCH 1/2] arm64: dts: orange-pi-zero-plus2: fix sdcard detect
In-Reply-To: <20171106161306.tq6yeq6bq36ridj3@speedy.hunter>
References: <20171103195855.15283-1-geomatsi@gmail.com>
 <20171103195855.15283-2-geomatsi@gmail.com>
 <CAMty3ZCs8kq1vUGLOi0ZghY7n0iXgUQ1E=ngBO6Y4wm7wMLF7Q@mail.gmail.com>
 <20171104154221.ao7kkcwqhnja3cxe@speedy.hunter>
 <20171106122633.5mnqfh6xhmmxr45s@flea>
 <20171106161306.tq6yeq6bq36ridj3@speedy.hunter>
Message-ID: <CAMty3ZCYQx0MfiJnOZPtO4nSAtOrGicOzw_x_AznTiEW8h2sLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 6, 2017 at 9:43 PM, Sergey Matyukevich <geomatsi@gmail.com> wrote:
> Hello Maxime,
>
>> > > > The sdcard detect pin on orange-pi-zero-plus2 is pulled up.
>> > > > Fix cd-gpio description to enable sdcard detect.
>> > > >
>> > > > Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
>> > > > ---
>> > > >  arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts | 2 +-
>> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > > >
>> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
>> > > > index b6b7a561df8c..a42fd79a62a3 100644
>> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
>> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
>> > > > @@ -71,7 +71,7 @@
>> > > >         pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
>> > > >         vmmc-supply = <&reg_vcc3v3>;
>> > > >         bus-width = <4>;
>> > > > -       cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
>> > > > +       cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
>> > >
>> > > Was able to detect and do mount with existing dts
>> >
>> > Did you try to boot from sdcard ? I am not able to boot my board from
>> > sd-card without this change. As I mentioned earlier in my email
>> > to buildroot mailing list, with mmc debug enabled I see that mmc
>> > tries to init sd-card when I remove it from the slot.
>> >
>> > Maybe there is a minor differences between h/w versions or batches ?
>> > What is you board version ? I tested on board v1.0.
>>
>> Looking at the schematics, it definitely looks like it's active low.
>
> Is it ok to merge it then ? Or using 'cd-inverted' property
> is the preferable option ?

W/o any change mainline works unstable for me, it wasn't booting
at-all[1] did you find the same?

Even tried with active LOW and cd-inverted.

[1] https://paste.ubuntu.com/25909064/

thanks!
-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
