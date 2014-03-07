From: christian.gmeiner@gmail.com (Christian Gmeiner)
Date: Fri, 7 Mar 2014 12:18:45 +0100
Subject: imx-drm: ldb and display power on sequence
In-Reply-To: <1394114410.3622.14.camel@paszta.hi.pengutronix.de>
References: <CAH9NwWcE=4OVHSMKCEuTrFA7JMGEdkxrbX_0OORZ96N1Roi2HQ@mail.gmail.com>
 <1394114410.3622.14.camel@paszta.hi.pengutronix.de>
Message-ID: <CAH9NwWfz4tBtuKqaJx_E4Y-a5eYwBaBPg2RgO4CFnE1Dfddi8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

> Am Donnerstag, den 06.03.2014, 13:34 +0100 schrieb Christian Gmeiner:
>> Hi all.
>>
>> On our custom board design (imx6d) we are using a TFT-display
>> connceted via LVDS.
>> The datasheet [0] says that the display needs a defined power up
>> sequence. I need
>> to control the following stuff:
>>
>> - LCD_ON (gpio2 3)
>> - Backlight ON (gpio2 0)
>> - PMW for dimm
>>
>> At the moment I have the backlight suff ready:
>>
>>        backlight {
>>                compatible = "pwm-backlight";
>>                pwms = <&pwm4 0 50000>;
>>                enable-gpios = <&gpio2 0 0>;
>>
>>                brightness-levels = <0 1 2 3 4>;
>>                default-brightness-level = <4>;
>>        };
>>
>> Now I only need to enable the LCD_ON and wait 40ms before turning on
>> the LVDS clocks and data.
>
> This can be done by adding a regulator-enable-ramp-delay property to the
> gpio regulator.
>

Correct.

>> For this I tought to add a regulator support in
>> imx_ldb_encoder_commit(..) of imx-ldb.c.
>>That should give me the correct sequence for
>> LVDS on to LVDS data/clock. Now I only need to get the pwm-backlight
>> driver doing its work after ldb is ready.
>
> We should rather add drm_panel support to imx-ldb. I have just sent a
> patch for this.
> The simple-panel driver already supports regulator and backlight.
>

I am still life in the world of a stable kernel called 3.13.6 :) Will
backport the simple-panel driver
and will have a look at your patches - today.

greets
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
