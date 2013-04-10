From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Apr 2013 21:34:40 +0200
Subject: [PATCH 2/5] gpio/omap: remove extra context restores in
 *_runtime_resume()
In-Reply-To: <1365106576-31816-3-git-send-email-jon-hunter@ti.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
 <1365106576-31816-3-git-send-email-jon-hunter@ti.com>
Message-ID: <CACRpkdaR0tL=2uvr+SP4uKW-BPmAHm=mL3rkaD79ELyPhDF1ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 4, 2013 at 10:16 PM, Jon Hunter <jon-hunter@ti.com> wrote:

> From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>
> 68942edb09f69b6e09522d1d346665eb3aadde49 (gpio/omap: fix wakeups
> on level-triggered GPIOs) already restores the fallingdetect and
> risingdetect contexts in *_runtime_resume(). These registers were
> modified in *_runtime_suspend() to include even those configured
> as level-triggered since only edge-triggered gpios can generate
> wakeup events. Therefore, the old context restores of the same
> registers present later in the code is not needed any more.
> Remove them.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Patch applied unless somebody complains.

Yours,
Linus Walleij
