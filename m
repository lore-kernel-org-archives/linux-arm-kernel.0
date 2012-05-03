From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 May 2012 08:39:56 +0200
Subject: [PATCH v2 2/3] ARM: imx: Add imx5 cpuidle driver
In-Reply-To: <CAMXH7KE1jao1p5ZQ1aw8p7qzOQUftck22QTMKJ1oGwiPhY=FMA@mail.gmail.com>
References: <1335924760-796-1-git-send-email-rob.lee@linaro.org>
 <1335924760-796-3-git-send-email-rob.lee@linaro.org>
 <20120502073331.GS4141@pengutronix.de>
 <CAMXH7KE1jao1p5ZQ1aw8p7qzOQUftck22QTMKJ1oGwiPhY=FMA@mail.gmail.com>
Message-ID: <20120503063956.GE4141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 03:11:35PM -0500, Rob Lee wrote:
> Sascha,
> 
> >> ? ? ? mxc_iomux_v3_init(MX51_IO_ADDRESS(MX51_IOMUXC_BASE_ADDR));
> >> ? ? ? mxc_arch_reset_init(MX51_IO_ADDRESS(MX51_WDOG1_BASE_ADDR));
> >> - ? ? arm_pm_idle = imx5_idle;
> >> + ? ? arm_pm_idle = (void *)imx5_idle;
> >
> > I don't like this. It will cover all warnings when the prototype of
> > arm_pm_idle changes in future. Better add a static void imx5_idle
> > which calls a static int imx5_do_idle, then you have an idle function
> > which returns an int.
> >
> 
> What about using the following:
> 
> arm_pm_idle =  (void (*)(void))imx5_idle;
> 
> This will give warnings if arm_pm_idle prototype changes.

This surely works but will look suspicious for people looking at the
code.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
