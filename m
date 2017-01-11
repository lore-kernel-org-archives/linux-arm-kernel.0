From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 11 Jan 2017 10:45:13 -0800
Subject: [PATCH 33/62] watchdog: meson_wdt: Convert to use device managed
 functions and other improvements
In-Reply-To: <1484095516-12720-3-git-send-email-linux@roeck-us.net> (Guenter
 Roeck's message of "Tue, 10 Jan 2017 16:44:42 -0800")
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-3-git-send-email-linux@roeck-us.net>
Message-ID: <m2k2a177wm.fsf@baylibre.com>
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
> - Drop assignments to otherwise unused variables
> - Drop remove function
> - Drop platform_set_drvdata()
> - Use devm_watchdog_register_driver() to register watchdog device
> - Replace shutdown function with call to watchdog_stop_on_reboot()
>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Kevin Hilman <khilman@baylibre.com>
