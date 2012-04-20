From: rabin@rab.in (Rabin Vincent)
Date: Fri, 20 Apr 2012 17:58:09 +0530
Subject: BUG: sleeping function called from invalid context at
 /usr/local/src/linux-3.4-rc1/include/linux/freezer.h:46
In-Reply-To: <20347.61964.860903.97474@ipc1.ka-ro>
References: <20347.61964.860903.97474@ipc1.ka-ro>
Message-ID: <CAH+eYFA9+MpL4Ls8viiyvkxv56Q0=33pwNR8B_VW_6DY83t1tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 4, 2012 at 12:32, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> commit a0acae0e added a might_sleep() to try_to_freeze() in
> include/linux/freezer.h.
> This leads to the following BUG message each time a process is started
> when compiled with CONFIG_DEBUG_ATOMIC_SLEEP=y
>
> |BUG: sleeping function called from invalid context at /usr/local/src/linux-3.4-rc1/include/linux/freezer.h:46
> |in_atomic(): 0, irqs_disabled(): 128, pid: 619, name: rc

This is on ARM, right?  In this old thread, there is a patch from
Russell which fixes it, but it seems to have not been applied:

https://lkml.org/lkml/2011/8/25/231
