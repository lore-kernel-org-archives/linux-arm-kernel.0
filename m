From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 10 Aug 2010 14:00:55 +0200
Subject: [rtc-linux] [PATCH 1/2] rtc: rtc-lpc32xx: Introduce RTC driver
	for the LPC32XX SoC
In-Reply-To: <20100810102507.GB4268@pengutronix.de>
References: <1281370650-29520-1-git-send-email-wellsk40@gmail.com>
	<1281370650-29520-2-git-send-email-wellsk40@gmail.com>
	<20100810102507.GB4268@pengutronix.de>
Message-ID: <20100810120055.GD11268@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

> > +	retval = request_irq(rtc->irq, lpc32xx_rtc_alarm_interrupt,
> > +		IRQF_DISABLED, "rtcalarm", rtc);
> > +	if (retval < 0) {
> > +		dev_err(&pdev->dev, "Can't request interrupt\n");
> > +		goto err_free_irq;
> > +	}
> 
> I saw that a number of rtc-drivers register their irq after they
> register the device. I wonder if this is OK here? Couldn't it happen
> that after rtc_device_register() there is a preemption and another
> process could set the alarm? Then there is a race between interrupts
> already enabled and no handler available, no?
If you do it the other way around the irq might trigger and the handler
reports an irq for a device that doesn't exist yet.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
