From: v1ron@mail.ru (Roman Volkov)
Date: Mon, 21 Dec 2015 11:29:16 +0300
Subject: [PATCH 0/4] clocksource/vt8500: Fix hangs in small delays
In-Reply-To: <1450650492-18996-1-git-send-email-v1ron@mail.ru>
References: <1450650492-18996-1-git-send-email-v1ron@mail.ru>
Message-ID: <20151221112916.40373d2f@anonymous>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Dec 2015 01:28:08 +0300
Roman Volkov <v1ron@mail.ru> wrote:

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
> Roman Volkov (4):
>   clocksource/vt8500: Use [read\write]l_relaxed()
>   clocksource/vt8500: Remove the 'loops' variable
>   clocksource/vt8500: Use MIN_OSCR_DELTA from PXA
>   clocksource/vt8500: Add register R/W functions
> 
>  drivers/clocksource/vt8500_timer.c | 98
> +++++++++++++++++++++++++++----------- 1 file changed, 69
> insertions(+), 29 deletions(-)
> 

Please note that vt8500 maintainer (Tony Prisk) was silent in the last
year. Any suggestions on this?

Regards,
Roman
