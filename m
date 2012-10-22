From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Oct 2012 00:28:32 +0200
Subject: [PATCH] arm: sched: stop sched_clock() during suspend
In-Reply-To: <873916h1yi.fsf@deeprootsystems.com>
References: <1350906877-19410-1-git-send-email-balbi@ti.com>
 <873916h1yi.fsf@deeprootsystems.com>
Message-ID: <CACRpkdY6ox+iJAGdSD=e7Yj55TzDWqOmLqu2fSRXvKJxqwfkhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 7:05 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:

> However, in light of RT throttling, this a correctness issue for process
> accounting, so I agree that this should be done for all platforms
> instead of providing an optional 'needs suspend' version of the API,
> even though it means printk times no longer reflect time spent
> suspended.

Maybe we should get printk() to use the best clocksource
instead.

The reason AFAICT that printk() is using sched_clock() is that
it's supposed to be fast. But now it seems that it's not going
to return what printk() needs anymore.

(Dragging Stultz & Gleixner into this...)

Yours,
Linus Walleij
