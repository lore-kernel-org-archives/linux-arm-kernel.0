From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 17 Nov 2009 01:29:18 -0500
Subject: [PATCH 08/10] led: enable led in 88pm860x
In-Reply-To: <20091114050608.GD4463@core.coreip.homeip.net>
References: <771cded00911130103m35c45c08ydf07cc8555438d69@mail.gmail.com>
	<20091114050608.GD4463@core.coreip.homeip.net>
Message-ID: <771cded00911162229r1ea2401fv11e96167a7dbd5fd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 14, 2009 at 12:06 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, Nov 13, 2009 at 04:03:35AM -0500, Haojian Zhuang wrote:
>> +
>> +static void pm860x_led_set(struct led_classdev *cdev,
>> + ? ? ? ? ? ? ? ? ? ? ? ?enum led_brightness value)
>> +{
>> + ? ? struct pm860x_led *data = container_of(cdev, struct pm860x_led, cdev);
>> + ? ? struct pm860x_chip *chip = data->chip;
>> + ? ? unsigned char brightness;
>> + ? ? int offset;
>> + ? ? int ret = -EINVAL;
>> +
>> + ? ? if (data->port < 0)
>> + ? ? ? ? ? ? return;
>
> Same here - if port is negative why even bother with creating led
> device?
>
> --
> Dmitry
>

Right. I update code now.

Haojian
