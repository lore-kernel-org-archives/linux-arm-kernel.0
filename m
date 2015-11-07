From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 6 Nov 2015 16:02:43 -0800
Subject: [PATCH 1/4] watchdog: meson: Enable meson SoC specific data
In-Reply-To: <CAL9uMOH4i4ajkF2x7agHe2WZcHTJ=vs9cO+TGx8WGLOFVLZnig@mail.gmail.com>
References: <1446846906-31520-1-git-send-email-carlo@caione.org>
 <1446846906-31520-2-git-send-email-carlo@caione.org>
 <20151106221519.GB19791@roeck-us.net>
 <CAL9uMOH4i4ajkF2x7agHe2WZcHTJ=vs9cO+TGx8WGLOFVLZnig@mail.gmail.com>
Message-ID: <563D3FA3.8020305@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2015 02:47 PM, Carlo Caione wrote:
> On Fri, Nov 6, 2015 at 11:15 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>
[ ... ]

>>>
>>>   static int meson_restart_handle(struct notifier_block *this, unsigned long mode,
>>>                                void *cmd)
>>>   {
>>> -     u32 tc_reboot = MESON_WDT_DC_RESET | MESON_WDT_TC_EN;
>>> +     u32 tc_reboot = MESON_WDT_DC_RESET;
>>>        struct meson_wdt_dev *meson_wdt = container_of(this,
>>>                                                       struct meson_wdt_dev,
>>>                                                       restart_handler);
>>> +     tc_reboot |= BIT(meson_wdt->data->shift_enable);
>>>
>>
>> I am quite sure that this results in a checkpatch warning.
>> Did you run your patch through checkpatch ?
>
> Yeah, no error/warnings on that line.
>

There should be a warning since there is no empty line after the declarations.
Maybe checkpatch doesn't catch it because of the continuation line above.

Still, the extra line would be appreciated.

Thanks,
Guenter
