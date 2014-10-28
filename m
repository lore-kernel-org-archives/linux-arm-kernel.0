From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Oct 2014 16:51:50 +0100
Subject: [PATCH 1/4] pinctrl: rockchip: Set wake_enabled
In-Reply-To: <1413847670-12245-1-git-send-email-dianders@chromium.org>
References: <1413847670-12245-1-git-send-email-dianders@chromium.org>
Message-ID: <CACRpkdZO+TuCodDzLZ2evRc0ak+4of38aKNqCiC5cMkm++keHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 21, 2014 at 1:27 AM, Doug Anderson <dianders@chromium.org> wrote:

> The rockchip pinctrl driver uses irq_gc_set_wake() but doesn't setup
> the .wake_enabled member.  That means that we can never actually use a
> pin for wakeup.  When "irq_set_irq_wake()" tries to call through it
> will always get a failure from set_irq_wake_real() and will then set
> wake_depth to 0.  Assuming you can resume you'll later get an error
> message about "Unbalanced IRQ x wake disable".
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Heiko, are you looking at this patch series? Need you Reviewed-by
to merge this stuff.

Yours,
Linus Walleij
