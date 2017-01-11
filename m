From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 11 Jan 2017 10:44:45 -0800
Subject: [PATCH 32/62] watchdog: meson_gxbb_wdt: Convert to use device
 managed functions and other improvements
In-Reply-To: <1484095516-12720-2-git-send-email-linux@roeck-us.net> (Guenter
 Roeck's message of "Tue, 10 Jan 2017 16:44:41 -0800")
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-2-git-send-email-linux@roeck-us.net>
Message-ID: <m2o9zd77xe.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guenter Roeck <linux@roeck-us.net> writes:

> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
> Other improvements as listed below.
>
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts used
> to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>
> - Use devm_add_action_or_reset() for calls to clk_disable_unprepare
> - Check return value from clk_prepare_enable()
> - Replace 'val = e; return val;' with 'return e;'
> - Replace 'if (e) return e; return 0;' with 'return e;'
> - Drop assignments to otherwise unused variables
> - Replace 'if (e) { return expr; }' with 'if (e) return expr;'
> - Drop remove function
> - Use devm_watchdog_register_driver() to register watchdog device
> - Replace shutdown function with call to watchdog_stop_on_reboot()
>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Nice, thanks for the cleanup!

Acked-by: Kevin Hilman <khilman@baylibre.com>
