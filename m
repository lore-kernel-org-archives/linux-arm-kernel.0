From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 10 Aug 2010 21:08:18 +0200
Subject: [rtc-linux] [PATCH 1/2] rtc: rtc-lpc32xx: Introduce RTC driver
	for  the LPC32XX SoC
In-Reply-To: <20100810153448.17443314@linux.lan.towertech.it>
References: <1281370650-29520-1-git-send-email-wellsk40@gmail.com>
	<1281370650-29520-2-git-send-email-wellsk40@gmail.com>
	<20100810153448.17443314@linux.lan.towertech.it>
Message-ID: <083DF309106F364B939360100EC290F80AC6E5F76E@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alessandro,

Thanks for helping to review this.

> 
> > +
> > +	retval = request_irq(rtc->irq, lpc32xx_rtc_alarm_interrupt,
> > +		IRQF_DISABLED, "rtcalarm", rtc);
> > +	if (retval < 0) {
> > +		dev_err(&pdev->dev, "Can't request interrupt\n");
> > +		goto err_free_irq;
> > +	}
> 
>  if the driver can work without the alarm irq you
>  can convert this to a non fatal warning.
> 
>  having an rtc without alarms is much better than having none.
> 

Good suggestion. I'll change this.

> --
> 
>  Best regards,
> 
>  Alessandro Zummo,
>   Tower Technologies - Torino, Italy
> 
>   http://www.towertech.it
> 
