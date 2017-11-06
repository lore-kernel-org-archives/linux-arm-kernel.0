From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon, 6 Nov 2017 15:58:15 +0530
Subject: [PATCH 1/2] arm64: dts: orange-pi-zero-plus2: fix sdcard detect
In-Reply-To: <20171104162206.gowih7h7og3fk7rk@speedy.hunter>
References: <20171103195855.15283-1-geomatsi@gmail.com>
 <20171103195855.15283-2-geomatsi@gmail.com>
 <CAMty3ZCs8kq1vUGLOi0ZghY7n0iXgUQ1E=ngBO6Y4wm7wMLF7Q@mail.gmail.com>
 <20171104154221.ao7kkcwqhnja3cxe@speedy.hunter>
 <CAMty3ZCxXUaBf3t=3d7D+RU6rp83oJw8BHADU3TYDeM4Vx_k-w@mail.gmail.com>
 <20171104162206.gowih7h7og3fk7rk@speedy.hunter>
Message-ID: <CAMty3ZBi1pscPLQyc4S075pvzyh-2wsSPnqqEuQgDFQ_c5oyFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 4, 2017 at 9:52 PM, Sergey Matyukevich <geomatsi@gmail.com> wrote:
>> > > The sdcard detect pin on orange-pi-zero-plus2 is pulled up.
>> > > Fix cd-gpio description to enable sdcard detect.
>> > >
>> > > Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
>> > > ---
>> > >  arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
>> > > index b6b7a561df8c..a42fd79a62a3 100644
>> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
>> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
>> > > @@ -71,7 +71,7 @@
>> > >         pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
>> > >         vmmc-supply = <&reg_vcc3v3>;
>> > >         bus-width = <4>;
>> > > -       cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
>> > > +       cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
>> >
>> > Was able to detect and do mount with existing dts
>>
>> Did you try to boot from sdcard ? I am not able to boot my board from
>> sd-card without this change. As I mentioned earlier in my email
>> to buildroot mailing list, with mmc debug enabled I see that mmc
>> tries to init sd-card when I remove it from the slot.
>>
>> Maybe there is a minor differences between h/w versions or batches ?
>> What is you board version ? I tested on board v1.0.
>>
>>
>> I'm using same v1.0
>
> Ok, lets skip this patch for now.
>
> I will double check v1.0 schematics and my board behavior.
> Though I see that mmc0 dts fragment in u-boot for this board
> also differs from the current kernel one: it uses 'cd-inverted' property.

Can you shared the hang log.. look like I've seen boot issue with
Latest Linux and U-Boot.

[    1.348668] ALSA device list:
[    1.351649]   No soundcards found.
[    1.355388] Waiting for root device /dev/mmcblk0p2...
[    1.371117] mmc1: new high speed MMC card at address 0001
[    1.376947] mmcblk1: mmc1:0001 8WPD3R 7.28 GiB
[    1.381623] mmcblk1boot0: mmc1:0001 8WPD3R partition 1 4.00 MiB
[    1.387682] mmcblk1boot1: mmc1:0001 8WPD3R partition 2 4.00 MiB
[    1.395036]  mmcblk1: p1 p2 p3 < p5 p6 p7 p8 p9 p10 p11 p12 p13 p14
p15 p16 p17 >
[    1.402542] mmcblk1: p1 size 6873088 extends beyond EOD, truncated

<< hang..>>

thanks!
-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
