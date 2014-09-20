From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 20 Sep 2014 08:30:28 -0700
Subject: [PATCH v3 2/4] ARM: meson: add watchdog driver
In-Reply-To: <1411158989-8075-3-git-send-email-carlo@caione.org>
References: <1411158989-8075-1-git-send-email-carlo@caione.org>
 <1411158989-8075-3-git-send-email-carlo@caione.org>
Message-ID: <541D9D94.2010400@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2014 01:36 PM, Carlo Caione wrote:
> This patch adds the watchdog driver for the Amlogic Meson SoCs used also
> to reboot the device.
>
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
[ ... ]
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
> +		"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +

Checkpatch says:

WARNING: quoted string split across lines
#295: FILE: drivers/watchdog/meson_wdt.c:231:
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
+		"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");

Please fix.

Thanks,
Guenter
