From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Jan 2017 16:48:25 +0100
Subject: [PATCH 10/62] watchdog: coh901327_wdt: Convert to use device
 managed functions
In-Reply-To: <1484091325-9199-11-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484091325-9199-11-git-send-email-linux@roeck-us.net>
Message-ID: <CACRpkdakLhH1Te85deJ3Gmwo0VNSrTspcFjBA75N_vgYwESc+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 12:34 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
>
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts used
> to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>
> - Use devm_add_action_or_reset() for calls to clk_disable_unprepare
> - Use devm_clk_get() if the device parameter is not NULL
> - Replace 'goto l; ... l: return e;' with 'return e;'
> - Replace 'val = e; return val;' with 'return e;'
> - Replace 'if (e) { return expr; }' with 'if (e) return expr;'
> - Replace request_irq, request_threaded_irq, and request_any_context_irq
>   with their device managed equivalent
> - Replace &pdev->dev with dev if 'struct device *dev' is a declared
>   variable
> - Use devm_watchdog_register_driver() to register watchdog device
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
