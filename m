From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 17 Feb 2011 11:54:15 +0100
Subject: [PATCH v2 1/2] ARM: IMX5: cpuidle driver
In-Reply-To: <AANLkTim_7HiWutTyTuWvAR5sx1Nd7HdSyhfwRjS2CfYg@mail.gmail.com>
References: <1297416973-32740-1-git-send-email-yong.shen@linaro.org>
	<1297416973-32740-2-git-send-email-yong.shen@linaro.org>
	<20110215182752.GD2027@pengutronix.de>
	<AANLkTim_7HiWutTyTuWvAR5sx1Nd7HdSyhfwRjS2CfYg@mail.gmail.com>
Message-ID: <20110217105415.GB24426@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 17, 2011 at 09:18:11AM +0100, Yong Shen wrote:
> >
> >
> > > +     return 0;
> > > +}
> > > +
> > > +late_initcall(imx_cpuidle_init);
> >
> > We have a late_initcall here which needs to be protected from other
> > cpus. On the other hand we depend on board code calling
> > imx_cpuidle_board_params() before this initcall. I think the board code
> > should call a imx_cpuidle_init(struct imx_cpuidle_params
> > *cpuidle_params) instead which makes the flow of execution more clear.
> >
> > imx_cpuidle_init can not be called directly in board code, since it is too
> early to register cpuidle driver and device which depend on some other
> system resource.

I see. Maybe we should make this a platform driver then like for example
davinci does.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
