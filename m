From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Tue, 20 Mar 2012 08:05:29 +0530
Subject: [PATCH v4 00/12] gpio/omap: Some more driver cleanup and fixes
In-Reply-To: <87aa3c3y6k.fsf@ti.com>
References: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
 <87aa3c3y6k.fsf@ti.com>
Message-ID: <CAC83ZvJnhnh-=Kwd4cuRvuCEKjgNWAdw2OK0_8GHb7_K6qk4mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2012 at 6:07 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> The cleanup is mostly getting rid of redundant fields in struct gpio_bank{}
>> as we already have them as part of bank->context now. Also, remove un-used
>> variable from gpio_irq_handler. Also, the suspend/resume callbacks are
>> removed bacause they are not needed any more.
>
> OK.
>
>> The fixes include correction of _set_gpio_irqenable() implementation,
>> missing wakeup_en register update in set_gpio_wakeup(), type mismatch
>> of gpio trigger parameter in set_gpio_trigger(), incorrect dataout
>> register update in set_gpio_dataout_() and few corrections in context
>> save logic.
>
> These fixes need to be separated out from the cleanups and prepared for
> v3.4-rc. ?We need these as standlone fixes (indepenent of the cleanups)
> so they can be applied for 3.4-rc. ?The rest of the cleanups will have
> to wait until 3.5.
Sure, I will separate out the fixes and prepare new series.

>
>> It is baselined on top of:
>> git://git.secretlab.ca/git/linux-2.6.git gpio/next
>> Commit: 81b279d80a63628e580c71a31d30a8c3b3047ad4
>>
>> Series is available here for reference:
>> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev for_3.4/gpio_more_cleanup_fixes
>>
>> Power Test:
>> Off-mode and Retention on OMAP3430 (Suspend and Idle paths).
>> Also confirmed that dataout register content preserved over
>> off-mode.
>
> I've confirmed these fixes also correct off-mode GPIO ouptut glitches
> that I was seeing on n900.
OK, thanks.
--
Tarun
>
> Kevin
