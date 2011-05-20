From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 May 2011 23:50:45 +0200
Subject: [PATCH v2] ARM: smp_twd: Reconfigure clockevents after cpufreq
	change
In-Reply-To: <1305851091-10096-1-git-send-email-ccross@android.com>
References: <1305851091-10096-1-git-send-email-ccross@android.com>
Message-ID: <BANLkTikzhC68w1AD59Vqw2vopDwu=YjOEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2011 at 2:24 AM, Colin Cross <ccross@android.com> wrote:

> The localtimer's clock changes with the cpu clock. ?After a
> cpufreq transition, update the clockevent's frequency and
> reprogram the next clock event.
>
> Adds a clock called "smp_twd" that is used to determine the
> twd frequency, which can also be used at init time to
> avoid calibrating the twd frequency.
>
> Clock changes are based on Rob Herring's work.
>
> Change-Id: I413b5cd07fb2b79bc9fad8b4bf257332d1da7bcd
> Signed-off-by: Colin Cross <ccross@android.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Rob Herring <robherring2@gmail.com>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>

OK Thomas can you take this in through the clock/timer
branch? Works fine for me and Colin and solves many problems
apart from making the code look neat.

Yours,
Linus Walleij
