From: alchark@gmail.com (Alexey Charkov)
Date: Thu, 24 Dec 2015 12:12:48 +0300
Subject: [PATCH v2 0/3] clocksource/vt8500: Fix hangs in small delays
In-Reply-To: <1450906511-342-1-git-send-email-v1ron@mail.ru>
References: <1450906511-342-1-git-send-email-v1ron@mail.ru>
Message-ID: <CABjd4Yx82Mu2YSNrzcHnq+giaz9hSha_=P0mC_UO-m1XuP4EMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-12-24 0:35 GMT+03:00 Roman Volkov <v1ron@mail.ru>:
> From: Roman Volkov <rvolkov@v1ros.org>
>
> vt8500 hangs in nanosleep() function, starting from commit
> c6eb3f70d4482806dc2d3e1e3c7736f497b1d418, making the system unusable.
> Per investigation, looks like set_next_event() now receives too small
> delta and fails with -ETIME.
>
> Google group discussion:
> https://groups.google.com/forum/#!topic/vt8500-wm8505-linux-kernel/vDMF_mDOb1k
>
> v2:
> Address comments by Alexey Charkov. Merge patches to get less amount of
> changes (three patches instead of four).
>
> Tested on my WM8650, no issues in three days uptime.
>
> Roman Volkov (3):
>   clocksource/vt8500: Use MIN_OSCR_DELTA from PXA
>   clocksource/vt8500: Remove the 'loops' variable
>   clocksource/vt8500: Add register R/W functions
>
>  drivers/clocksource/vt8500_timer.c | 98 +++++++++++++++++++++++++++-----------
>  1 file changed, 69 insertions(+), 29 deletions(-)

This whole series looks good to me as far as VT8500 is concerned.
Thanks a lot Roman for fixing it and streamlining the bus
synchronization.

Acked-by: Alexey Charkov <alchark@gmail.com>

Daniel, Thomas, any chance you could push this to -next via your
clocksource tree?

Best regards,
Alexey
