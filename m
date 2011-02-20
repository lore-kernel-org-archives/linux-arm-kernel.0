From: yong.shen@linaro.org (Yong Shen)
Date: Sun, 20 Feb 2011 15:58:02 +0100
Subject: [PATCH v2 1/2] ARM: IMX5: cpuidle driver
In-Reply-To: <20110217105415.GB24426@pengutronix.de>
References: <1297416973-32740-1-git-send-email-yong.shen@linaro.org>
	<1297416973-32740-2-git-send-email-yong.shen@linaro.org>
	<20110215182752.GD2027@pengutronix.de>
	<AANLkTim_7HiWutTyTuWvAR5sx1Nd7HdSyhfwRjS2CfYg@mail.gmail.com>
	<20110217105415.GB24426@pengutronix.de>
Message-ID: <AANLkTi=VkaCY5u-ibEKWU6=AiRkB5aZwPevY6A3bmk0T@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

I had sent out v3 patch before the your last comments.
I noticed how davinci is doing, but some SOCs like omap, they also do it in
another way like my code.
However, if you prefer the way davinci is doing, I will redo it. Please
confirm.

thanks
Yong

On Thu, Feb 17, 2011 at 11:54 AM, Sascha Hauer <s.hauer@pengutronix.de>wrote:

> On Thu, Feb 17, 2011 at 09:18:11AM +0100, Yong Shen wrote:
> > >
> > >
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +late_initcall(imx_cpuidle_init);
> > >
> > > We have a late_initcall here which needs to be protected from other
> > > cpus. On the other hand we depend on board code calling
> > > imx_cpuidle_board_params() before this initcall. I think the board code
> > > should call a imx_cpuidle_init(struct imx_cpuidle_params
> > > *cpuidle_params) instead which makes the flow of execution more clear.
> > >
> > > imx_cpuidle_init can not be called directly in board code, since it is
> too
> > early to register cpuidle driver and device which depend on some other
> > system resource.
>
> I see. Maybe we should make this a platform driver then like for example
> davinci does.
>
> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110220/59d8ac2c/attachment-0001.html>
