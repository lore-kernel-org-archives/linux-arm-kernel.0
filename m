From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 5 Dec 2011 14:44:14 +0530
Subject: [PATCH] backlight: add regulator support for platform_lcd driver
In-Reply-To: <20111205085228.GF9900@legolas.emea.dhcp.ti.com>
References: <1323074921-29291-1-git-send-email-thomas.abraham@linaro.org>
 <20111205085228.GF9900@legolas.emea.dhcp.ti.com>
Message-ID: <CAJuYYwTJOfCGUObv4+GakO8BN3N10=T6pH7MdCAiqtBrVGz1_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On 5 December 2011 14:22, Felipe Balbi <balbi@ti.com> wrote:

[...]

>> + ? ? if (lcd_power) {
>> + ? ? ? ? ? ? if (plcd->pdata->min_uV || plcd->pdata->max_uV)
>> + ? ? ? ? ? ? ? ? ? ? if (regulator_set_voltage(lcd_regulator,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? plcd->pdata->min_uV, plcd->pdata->max_uV))
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? dev_info(plcd->us,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "regulator voltage set failed\n");
>> +
>> + ? ? ? ? ? ? if (regulator_enable(lcd_regulator))
>> + ? ? ? ? ? ? ? ? ? ? dev_info(plcd->us, "failed to enable regulator\n");
>> + ? ? } else {
>> + ? ? ? ? ? ? regulator_disable(lcd_regulator);
>> + ? ? }
>> +
>> + ? ? regulator_put(lcd_regulator);
>
> I wonder why you ->get() and ->put() everytime here. Wouldn't it be
> enough to ->get() on probe() and ->put() on remove() ??

Thanks for the suggestion. It would be simpler if done in probe. I
will redo this patch.

Regards,
Thomas.

>
> --
> balbi
>
