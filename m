From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Aug 2015 13:12:31 +0200
Subject: [PATCH v4 3/4] gpio: brcmstb: support wakeup from S5 cold boot
In-Reply-To: <1438391865-7862-4-git-send-email-gregory.0xf0@gmail.com>
References: <1438391865-7862-1-git-send-email-gregory.0xf0@gmail.com>
 <1438391865-7862-4-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <CACRpkdaTwLHC528+p6ytPhR7POonECfU3_-EEz--nrs353UTXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 1, 2015 at 3:17 AM, Gregory Fong <gregory.0xf0@gmail.com> wrote:

> For wake from S5, we need to:
> - register a reboot handler
> - set wakeup capability before requesting IRQ so wakeup count is
>   incremented
> - mask all GPIO IRQs and clear any pending interrupts during driver
>   probe to since no driver will yet be registered to handle any IRQs
>   carried over from boot at that time, and it's possible that the
>   booted kernel does not request the same IRQ anyway.
>
> This means that /sys/.../power/wakeup_count is valid at boot time, and
> we can properly account for S5 wakeup stats. e.g.:
>
>   ### After waking from S5 from a GPIO key
>   # cat /sys/bus/platform/drivers/brcmstb-gpio/f04172c0.gpio/power/wakeup
>   enabled
>   # cat /sys/bus/platform/drivers/brcmstb-gpio/f04172c0.gpio/power/wakeup_count
>   1
>
> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
> ---
> v4: rename __brcmstb_gpio_irq_set_wake() to brcmstb_gpio_priv_set_wake().

Patch applied.

Yours,
Linus Walleij
