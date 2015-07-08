From: peter@piie.net (Peter Feuerer)
Date: Wed, 08 Jul 2015 10:11:24 +0200
Subject: [PATCH] thermal: consistently use int for temperatures
References: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <cone.1436343084.787318.20214.1000@mups>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer writes:

> The thermal code uses int, long and unsigned long for temperatures
> in different places.
> 
> Using an unsigned type limits the thermal framework to positive
> temperatures without need. Also several drivers currently will report
> temperatures near UINT_MAX for temperatures below 0?C. This will probably
> immediately shut the machine down due to overtemperature if started below
> 0?C.
> 
> 'long' is 64bit on several architectures. This is not needed since INT_MAX ?mC
> is above the melting point of all known materials.
> 
> Consistently use a plain 'int' for temperatures throughout the thermal code and
> the drivers. This only changes the places in the drivers where the temperature
> is passed around as pointer, when drivers internally use another type this is
> not changed.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: linux-pm at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Peter Feuerer <peter@piie.net>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-acpi at vger.kernel.org
> Cc: platform-driver-x86 at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-omap at vger.kernel.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: lm-sensors at lm-sensors.org
> ---

[...]

For:

>  drivers/platform/x86/acerhdf.c                     |  9 ++++----
>  drivers/thermal/gov_bang_bang.c                    |  5 ++--

Reviewed-by: Peter Feuerer <peter@piie.net>

[...]


-- 
--peter;
