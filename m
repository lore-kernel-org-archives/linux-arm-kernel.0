From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Jan 2014 15:05:33 +0100
Subject: [PATCH 7/8] ARM: Convert boot_lock to raw_lock [ux500]
In-Reply-To: <1387532866-22601-8-git-send-email-bigeasy@linutronix.de>
References: <1387532866-22601-1-git-send-email-bigeasy@linutronix.de>
 <1387532866-22601-8-git-send-email-bigeasy@linutronix.de>
Message-ID: <CACRpkdbsJsJWzhTY4D12vdxXznO7ejn+KySZOgqKJrTGULc1Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 10:47 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:

> From: Frank Rowand <frank.rowand@am.sony.com>
>
> The arm boot_lock is used by the secondary processor startup code.  The locking
> task is the idle thread, which has idle->sched_class == &idle_sched_class.
> idle_sched_class->enqueue_task == NULL, so if the idle task blocks on the
> lock, the attempt to wake it when the lock becomes available will fail:
>
> try_to_wake_up()
>    ...
>       activate_task()
>          enqueue_task()
>             p->sched_class->enqueue_task(rq, p, flags)
>
> Fix by converting boot_lock to a raw spin lock.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Frank Rowand <frank.rowand@sonymobile.com>
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> Link: http://lkml.kernel.org/r/4E77B952.3010606 at am.sony.com
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

A bit late I guess, but anyway:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
