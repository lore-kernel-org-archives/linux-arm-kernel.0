From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Mon, 7 Nov 2011 16:41:37 +0530
Subject: [PATCH v8 REPOST 21/24] gpio/omap: save and restore debounce
 registers
In-Reply-To: <87zkgbbzaq.fsf@ti.com>
References: <1318422730-22282-1-git-send-email-tarun.kanti@ti.com>
 <87zkgbbzaq.fsf@ti.com>
Message-ID: <CAC83ZvK=8DiiBeHHK+yKkn4UwRkdkd58m+F52L9NjJUqRW9wcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 4, 2011 at 10:27 PM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Nishanth Menon <nm@ti.com>
>>
>> GPIO debounce registers need to be saved and restored for proper functioning
>> of driver.
>
> OK.
>
>> To save the registers, we cannot cut the clock before the save,
>> hence move the clk disable after the save.
>
> This patch doesn't move any clk disable.
>
> I suspect you made some changes to the original patch from Nishanth.
> Please note that in the changelog. ?This is typically done by adding
> something like:
>
> [my at email.addr: describe changes made]
>
> just before your signoff.
Yes, quite a bit of changes happened which not captured in the description.
The save context has been moved from *_runtime_suspend() to _set_gpio_debounce()
as part of your comment in v6 to reduce overhead.
Also, the clock disable is moved to *_prepare_for_idle().
I will add changelog to capture above changes.
--
Tarun
>
> Kevin
>
