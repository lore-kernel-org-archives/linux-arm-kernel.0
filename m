From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Thu, 31 Jul 2014 19:14:59 +0200
Subject: [PATCH v4 4/4] ARM: dts: Add exynos5250-spring device tree
In-Reply-To: <CAP_ceTz+KRJzF9XV=_aLE+6sV6d5GqCtQ_daKtpFJfCZQ1erpA@mail.gmail.com>
References: <1406822910-6255-1-git-send-email-afaerber@suse.de>
 <1406822910-6255-5-git-send-email-afaerber@suse.de>
 <CAP_ceTz+KRJzF9XV=_aLE+6sV6d5GqCtQ_daKtpFJfCZQ1erpA@mail.gmail.com>
Message-ID: <53DA7993.1000800@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 31.07.2014 19:00, schrieb Vincent Palatin:
> Always a bit late to the game.
> One small comment inline.
> 
> Reviewed-by: Vincent Palatin <vpalatin@chromium.org>

Thanks,

> 
> On Thu, Jul 31, 2014 at 9:08 AM, Andreas F?rber <afaerber@suse.de> wrote:
>> +       usb3_vbus_reg: regulator-usb3 {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "P5.0V_USB3CON";
>> +               regulator-min-microvolt = <5000000>;
>> +               regulator-max-microvolt = <5000000>;
>> +               gpio = <&gpe1 0 GPIO_ACTIVE_LOW>;
>> +               enable-active-high;
>> +       };
> 
> GPE1_0 GPIO is the HSIC hub (SMSC 3503) reset# line (already defined
> below afaik).

Yes, that was a suggestion you made on v1.

> On this design there is no external USB3 port, so no VBUS reg/load
> switch for USB3.

Could you be a little clearer? Are you suggesting to drop the gpio
property? I just re-tested that without the regulator node plus the
vbus-supply below I don't get any USB2 (so maybe rename the regulator?).

Regards,
Andreas

>> +
>> +       usb at 12110000 {
>> +               samsung,vbus-gpio = <&gpx1 1 GPIO_ACTIVE_HIGH>;
>> +       };
>> +
>> +       usb-hub {
>> +               compatible = "smsc,usb3503a";
>> +               reset-gpios = <&hsic_reset>;
>> +       };
[...]
>> +&usbdrd_phy {
>> +       vbus-supply = <&usb3_vbus_reg>;
>> +};
>> +
>> +#include "cros-ec-keyboard.dtsi"
>> --
>> 1.9.3

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
