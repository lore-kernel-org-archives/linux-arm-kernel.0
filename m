From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 8 Oct 2014 08:57:56 -0700
Subject: [PATCH 4/4] watchdog: st_wdt: Add new driver for ST's LPC Watchdog
In-Reply-To: <1412760810-23199-5-git-send-email-lee.jones@linaro.org>
References: <1412760810-23199-1-git-send-email-lee.jones@linaro.org>
 <1412760810-23199-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20141008155756.GA17676@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 10:33:30AM +0100, Lee Jones wrote:
> Signed-off-by: David Paris <david.paris@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/watchdog/Kconfig  |  16 +++
>  drivers/watchdog/Makefile |   1 +
>  drivers/watchdog/st_wdt.c | 317 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 334 insertions(+)
>  create mode 100644 drivers/watchdog/st_wdt.c
> 

Unfortunately (built with W=1):

drivers/watchdog/st_wdt.c: In function 'st_wdog_load_timer':
drivers/watchdog/st_wdt.c:114:14: warning: comparison between signed and
unsigned integer expressions [-Wsign-compare]
drivers/watchdog/st_wdt.c: In function 'st_wdog_remove':
drivers/watchdog/st_wdt.c:273:24: error: 'clk' undeclared (first use in this
function)

and checkpatch complains a bit: 

WARNING: please, no space before tabs
#303: FILE: drivers/watchdog/st_wdt.c:236:
+^Ist_wdog->dev ^I^I= &pdev->dev;$

WARNING: please, no space before tabs
#304: FILE: drivers/watchdog/st_wdt.c:237:
+^Ist_wdog->base ^I^I= base;$

WARNING: please, no space before tabs
#306: FILE: drivers/watchdog/st_wdt.c:239:
+^Ist_wdog->warm_reset ^I= of_property_read_bool(np, "st,warm_reset");$

Guenter
