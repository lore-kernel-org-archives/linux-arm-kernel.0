From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 17 Nov 2009 01:30:20 -0500
Subject: [PATCH 07/10] backlight: enable backlight in 88pm860x
In-Reply-To: <20091114050257.GC4463@core.coreip.homeip.net>
References: <771cded00911130102k36662e51j34e7e2825fdbde66@mail.gmail.com>
	<20091114050257.GC4463@core.coreip.homeip.net>
Message-ID: <771cded00911162230x25f5ad7cx6adad4c5e929fa3c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 14, 2009 at 12:02 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, Nov 13, 2009 at 04:02:24AM -0500, Haojian Zhuang wrote:
>> +
>> +static int pm860x_backlight_set(struct backlight_device *bl, int brightness)
>> +{
>> + ? ? struct pm860x_backlight_data *data = bl_get_data(bl);
>> + ? ? struct pm860x_chip *chip = data->chip;
>> + ? ? unsigned char value;
>> + ? ? int ret;
>> +
>> + ? ? if ((wled_a(data->port) < 0) || (wled_b(data->port) < 0)
>> + ? ? ? ? ? ? || (wled_idc(data->port) < 0))
>> + ? ? ? ? ? ? return -EINVAL;
>> +
>
> Do you even need to register blacklight device if data->port is negative?
>
> --
> Dmitry
>

Right. Code is updated.

Haojian
