From: yong.shen@linaro.org (Yong Shen)
Date: Thu, 17 Feb 2011 09:18:11 +0100
Subject: [PATCH v2 1/2] ARM: IMX5: cpuidle driver
In-Reply-To: <20110215182752.GD2027@pengutronix.de>
References: <1297416973-32740-1-git-send-email-yong.shen@linaro.org>
	<1297416973-32740-2-git-send-email-yong.shen@linaro.org>
	<20110215182752.GD2027@pengutronix.de>
Message-ID: <AANLkTim_7HiWutTyTuWvAR5sx1Nd7HdSyhfwRjS2CfYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
>
> > +     return 0;
> > +}
> > +
> > +late_initcall(imx_cpuidle_init);
>
> We have a late_initcall here which needs to be protected from other
> cpus. On the other hand we depend on board code calling
> imx_cpuidle_board_params() before this initcall. I think the board code
> should call a imx_cpuidle_init(struct imx_cpuidle_params
> *cpuidle_params) instead which makes the flow of execution more clear.
>
> imx_cpuidle_init can not be called directly in board code, since it is too
early to register cpuidle driver and device which depend on some other
system resource.

Yong
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110217/407ee15f/attachment-0001.html>
