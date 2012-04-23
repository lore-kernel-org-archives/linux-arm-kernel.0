From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 23 Apr 2012 13:18:21 +0800
Subject: [PATCH 1/3] ARM: imx: Add common imx cpuidle init functionality.
In-Reply-To: <CAMXH7KE2RtdNy3G61guZb2uWy3rn267Z3eEVEgN5e==tHHsiuA@mail.gmail.com>
References: <1334620214-25803-1-git-send-email-rob.lee@linaro.org>
 <1334620214-25803-2-git-send-email-rob.lee@linaro.org>
 <20120417074301.GM20478@pengutronix.de>
 <CAMXH7KH41kWMPu_dEpetZc8OUD3C0-mtxGbXX0Vqd4EODPWJUg@mail.gmail.com>
 <20120417174213.GD3852@pengutronix.de>
 <CAMXH7KFYA24sPUcwgKfwVLNPA0jWQ-QG02y+SfPNnAqdiv0+gg@mail.gmail.com>
 <CAMXH7KGgSmvfqUTC1bufBz0QXbt01dHsPo1cbRA9jLj9mGmfjg@mail.gmail.com>
 <20120419064308.GH3852@pengutronix.de>
 <20120420020816.GH22219@S2101-09.ap.freescale.net>
 <CAMXH7KE2RtdNy3G61guZb2uWy3rn267Z3eEVEgN5e==tHHsiuA@mail.gmail.com>
Message-ID: <20120423051813.GM26306@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 22, 2012 at 11:44:39PM -0500, Rob Lee wrote:
> >> I don't think we need a cpu_is_imx6q(), but having some i.MX6 specific
> >> hook at device_initcall time can't be too wrong. Shawn?
> >>
> > Yep, it works for me.
> >
> Sascha, Shawn, thanks for the response.
> 
> Since device_initcall isn't platform specific, it seems I would still
> need a cpu_is_imx6q() function or similiar functionality from a device
> tree call.  Or do you have something else in mind that I'm not seeing?
> 
I guess Sascha is asking for something like the following.

static int __init imx_device_init(void)
{
	imx5_device_init();
	imx6_device_init();
}
device_initcall(imx_device_init)

static int __init imx6_device_init(void)
{
	/*
	 * do whatever needs to get done in device_initcall time
	 */
}

-- 
Regards,
Shawn
