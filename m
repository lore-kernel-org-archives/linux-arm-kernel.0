From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Aug 2015 13:38:19 +0200
Subject: [PATCH V2] Watchdog: Fix parent of watchdog_devices
In-Reply-To: <9fcc2a2cc8273f461baa13c6c9992f3ca56b508a.1439915117.git.panand@redhat.com>
References: <9fcc2a2cc8273f461baa13c6c9992f3ca56b508a.1439915117.git.panand@redhat.com>
Message-ID: <CACRpkdbT0Ew_LXys++EDykM-gp08dxKQ4HYp0CfAmk7EoCET9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 6:34 PM, Pratyush Anand <panand@redhat.com> wrote:

> /sys/class/watchdog/watchdogn/device/modalias can help to identify the
> driver/module for a given watchdog node. However, many wdt devices does not set
> its parent and so, we do not see an entry for device in sysfs for such devices.
>
> This patch fixes parent of watchdog_device so that
> /sys/class/watchdog/watchdogn/device is populated.
>
> Exceptions: booke, diag288, mpc8xxx, octeon, softdog and w83627hf -- They do not
> have any parent. Not sure, how we can we identify driver for these devices.
>
> Signed-off-by: Pratyush Anand <panand@redhat.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
