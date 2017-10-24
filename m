From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 24 Oct 2017 11:08:26 +0200
Subject: [PATCH 1/3] drm/exynos/dsi: Use common error handling code in
 exynos_dsi_enable()
In-Reply-To: <CAJKOXPc_QQ-QKkPWQoxj0LjeJsG2BjhP6X0X9m8YQEo=qTnOvg@mail.gmail.com>
References: <7d4cdb43-432c-c67a-5d3f-c37bd604f539@users.sourceforge.net>
 <9028478a-a00d-6fcd-0286-b8daefa8c912@users.sourceforge.net>
 <CAJKOXPc_QQ-QKkPWQoxj0LjeJsG2BjhP6X0X9m8YQEo=qTnOvg@mail.gmail.com>
Message-ID: <ac01b36a-2d5c-6852-2f2c-8aed89acdaba@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> @@ -1401,11 +1400,14 @@ static void exynos_dsi_enable(struct drm_encoder *encoder)
>>                 dsi->state &= ~DSIM_STATE_ENABLED;
>>                 exynos_dsi_set_display_enable(dsi, false);
>>                 drm_panel_unprepare(dsi->panel);
>> -               pm_runtime_put_sync(dsi->dev);
>> -               return;
>> +               goto put_sync;
>>         }
>>
>>         dsi->state |= DSIM_STATE_VIDOUT_AVAILABLE;
>> +       return;
>> +
>> +put_sync:
>> +       pm_runtime_put_sync(dsi->dev);
>>  }
> 
> No, this does not simplify the code.

How do you think about to check a bit more if there are desired effects to consider
when the shown function call is stored only once at the end of this function implementation?


> Stop using coccinelle.

This will not happen for a while. - There are so many source code places left over
where you might care more for similar software improvements.

Regards,
Markus
