From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 28 Jul 2012 01:32:50 +0200
Subject: [RFC v2] ARM: sched_clock: update epoch_cyc on resume
In-Reply-To: <1343184588-20239-1-git-send-email-ccross@android.com>
References: <1343184588-20239-1-git-send-email-ccross@android.com>
Message-ID: <CACRpkdZv4p+QT3Y+=-xh5iJ=sr1_aahroxQ535QpzVD9e_ESJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2012 at 4:49 AM, Colin Cross <ccross@android.com> wrote:

> Many clocks that are used to provide sched_clock will reset during
> suspend.  If read_sched_clock returns 0 after suspend, sched_clock will
> appear to jump forward.  This patch resets cd.epoch_cyc to the current
> value of read_sched_clock during resume, which causes sched_clock() just
> after suspend to return the same value as sched_clock() just before
> suspend.
>
> In addition, during the window where epoch_ns has been updated before
> suspend, but epoch_cyc has not been updated after suspend, it is unknown
> whether the clock has reset or not, and sched_clock() could return a
> bogus value.  Add a suspended flag, and return the pre-suspend epoch_ns
> value during this period.
>
> The new behavior is triggered by calling setup_sched_clock_needs_suspend
> instead of setup_sched_clock.
>
> Signed-off-by: Colin Cross <ccross@android.com>

Sweet!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
