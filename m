From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Jun 2013 10:39:34 +0200
Subject: [PATCH] gpiolib: remove warnning of allocations with IRQs disabled
In-Reply-To: <1370747312-25957-1-git-send-email-zhangfei.gao@linaro.org>
References: <1370747312-25957-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <CACRpkdY3FVkuWpSYe2XQjATVzUx7Wjn1rGgAjkKSwnW1G==AxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 9, 2013 at 5:08 AM, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:

> Move of_gpiochip_add outof spin_lock, since kzalloc inside
> of_gpiochip_add -> of_gpiochip_add_pin_range -> gpiochip_add_pin_range -> kzalloc
>
> WARNING: at kernel/lockdep.c:2740 lockdep_trace_alloc+0xf8/0xfc()
> DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Patch applied, thanks.

Yours,
Linus Walleij
