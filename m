From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 6 Aug 2012 16:12:31 +0200
Subject: [PATCH 2/4] gpio/mxc: specify gpio base for device tree probe
In-Reply-To: <1344146488-9496-2-git-send-email-shawn.guo@linaro.org>
References: <1344146488-9496-1-git-send-email-shawn.guo@linaro.org>
 <1344146488-9496-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120806141231.GA9329@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 05, 2012 at 02:01:26PM +0800, Shawn Guo wrote:
> Currently, unlike the non-DT probe where the gpio base is specified
> with pdev->id, the DT probe uses the base dynamically allocated by
> gpio core, which uses a completely different numbering scheme.  This
> causes two issues to user space applications which access sysfs entry
> /sys/class/gpio/gpioN.
> 
> * It breaks the compatibility with user space applications between
>   non-DT and DT kernels.
> 
> * It's not intuitive and sometimes hard for users to map the Linux
>   gpio number to the actual hardware pin.
> 
> Use alias to identify the gpio port/bank, and then the gpio base
> can be specified with port id to solve above issues.  If alias is not
> defined in device tree, the base number dynamically allocated by gpio
> core will be used.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
I applied patches 1, 2 and 4 to my imx35 dt tree and they work like a
charm.

Tested-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

for these three.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
