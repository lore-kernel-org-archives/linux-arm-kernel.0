From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 25 Nov 2013 09:16:13 -0500
Subject: [PATCH v3 1/6] watchdog: davinci: change driver to use WDT core
In-Reply-To: <1385388285-10553-2-git-send-email-ivan.khoronzhuk@ti.com>
References: <1385388285-10553-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1385388285-10553-2-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <52935BAD.9080908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ivan,

On Monday 25 November 2013 09:04 AM, Ivan Khoronzhuk wrote:
> To reduce code duplicate and increase code readability use WDT core
> code to handle WDT interface.
> 
> Remove io_lock as the WDT core uses mutex to lock each wdt device.
> Remove wdt_state as the WDT core tracks state with its own variable.
> 
> The watchdog_init_timeout() can read timeout value from timeout-sec
> property if the passed value is out of bounds. The heartbeat is
> initialized in next way. If heartbeat is not set thought module
> parameter, try to read it's value from WDT node timeout-sec property.
> If node has no one, use default value.
> 
> The heartbeat is hold in wdd->timeout by WDT core, so use it in
> order to set timeout period.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Minor suggestion regarding the SOB line which applies to
rest of the series as well. Typically your SOB line
should be the last one like below.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>

No need to repost the series just for that. The last
patch as I commented earlier, needs to be separate
patch which will go via linux-keystone tree.

Once the watchdog maintainer is happy with rest of the
series and applies it, I will pick last patch.

Regards,
Santosh
