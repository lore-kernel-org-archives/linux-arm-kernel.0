From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 16 Jan 2017 16:36:54 -0200
Subject: [PATCH 3/3] watchdog: imx2: add compatibility for new i.MX35 type
 watchdog
In-Reply-To: <20170109095039.11979-4-u.kleine-koenig@pengutronix.de>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
 <20170109095039.11979-4-u.kleine-koenig@pengutronix.de>
Message-ID: <CAOMZO5DKtWMuYxOzuwkvVC5nqVRqHFj06X_vLxxkJ5i3hrpO4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 9, 2017 at 7:50 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> When the watchdog driver learned about the i.MX35 type watchdog a new
> compatibility string was introduced. Older dtb continue to use the
> old fsl,imx21-wdt string and so stop writing the WMCR register which is
> critical iff the machine powers off when WDOG becomes active and the
> bootloader doesn't stop the power down counter.
>
> It's unknown which boards are affected and I guess most of them are not.

At least imx31 pdk is affected.

> Also note this is only an issue if a new kernel is operated with an old
> dtb as the SoC dtsi files are fixed accordingly.
>
> XXX: the XXX introduced needs to be changed to HEAD~2 when got a stable commit id.

This comment should not be here.


Other than that:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
