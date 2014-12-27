From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 27 Dec 2014 20:58:25 +0100
Subject: [PATCH 2/3] hwmon: Driver for OMAP3 temperature sensor
In-Reply-To: <1419597294-21487-3-git-send-email-sre@kernel.org>
References: <20141226102933.GA28778@amd>
 <1419597294-21487-1-git-send-email-sre@kernel.org>
 <1419597294-21487-3-git-send-email-sre@kernel.org>
Message-ID: <20141227195825.GF10007@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2014-12-26 13:34:53, Sebastian Reichel wrote:
> OMAP34xx and OMAP36xx processors contain a register in the syscon area,
> which can be used to determine the SoCs temperature. This patch provides
> a DT based driver for the temperature sensor based on an older driver
> written by Peter De Schrijver for the Nokia N900 and N9.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/hwmon/Kconfig      |   8 ++
>  drivers/hwmon/Makefile     |   1 +
>  drivers/hwmon/omap3-temp.c | 307 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 316 insertions(+)
>  create mode 100644 drivers/hwmon/omap3-temp.c

When it hangs, it loops here:

do {
regmap_read(data->syscon, SYSCON_TEMP_REG,&temp_sensor_reg);
if ((temp_sensor_reg & eocz_mask) == level)
   return true;
printk("=");
}
while (ktime_us_delta(expire, ktime_get()) > 0);

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
