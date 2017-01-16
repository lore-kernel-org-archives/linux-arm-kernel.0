From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 16 Jan 2017 16:34:00 -0200
Subject: [PATCH 1/3] watchdog: imx2: Only i.MX35 and later have a WMCR
 register
In-Reply-To: <20170109095039.11979-2-u.kleine-koenig@pengutronix.de>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
 <20170109095039.11979-2-u.kleine-koenig@pengutronix.de>
Message-ID: <CAOMZO5Bd8_R8i7SeoKuaVJ2EEFD-DA3PJ=QOmcnPtSdXqd+zHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 9, 2017 at 7:50 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Commit 5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on
> boot") introduced a write to the WMCR register that doesn't exist on
> i.MX21, i.MX27 and i.MX31 and so makes the SoC hang during probe.
>
> So teach the driver to differentiate between these two types. Note that
> this effectively undoes commit 5fe65ce7ccbb for machines using dt until
> their dtb is updated accordingly. This is critical iff the bootloader
> doesn't disable the power down counter and the #WDOG signal actually
> does something to the machine.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
