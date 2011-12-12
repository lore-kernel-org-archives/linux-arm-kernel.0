From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Dec 2011 15:28:21 +0100
Subject: [PATCH 6/7] arm/imx6q: add cpufreq support
In-Reply-To: <20111212134643.GC16835@b20223-02.ap.freescale.net>
References: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
 <1323661352-10291-7-git-send-email-richard.zhao@linaro.org>
 <20111212124436.GT27267@pengutronix.de>
 <20111212134643.GC16835@b20223-02.ap.freescale.net>
Message-ID: <20111212142821.GZ27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 09:46:43PM +0800, Richard Zhao wrote:
> > > +{
> > > +	if (strncmp(p, "1000", 4) == 0)
> > > +		arm_max_freq = 1000;
> > > +	else if (strncmp(p, "800", 3) == 0)
> > > +		arm_max_freq = 800;
> > > +	return 0;
> > > +}
> > > +
> > > +early_param("arm_freq", set_arm_max_freq);
> > 
> > Do we need this? I suppose this should be passed by the device tree if
> > necessary.
> Yes, we do. Some boards don't support 1G. Would you let it be a temp solution? Or I'll
> only support 1G boards.
> For long time, maybe we put all operating points to dts or opp. Which one will
> you prefer?  It needs much other work to do.

I see several boards already having a clock-frequency property in their
cpu node, so you could use this as maximum frequency.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
