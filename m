From: a.zummo@towertech.it (Alessandro Zummo)
Date: Tue, 10 Aug 2010 15:34:48 +0200
Subject: [rtc-linux] [PATCH 1/2] rtc: rtc-lpc32xx: Introduce RTC driver
	for  the LPC32XX SoC
In-Reply-To: <1281370650-29520-2-git-send-email-wellsk40@gmail.com>
References: <1281370650-29520-1-git-send-email-wellsk40@gmail.com>
	<1281370650-29520-2-git-send-email-wellsk40@gmail.com>
Message-ID: <20100810153448.17443314@linux.lan.towertech.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  9 Aug 2010 09:17:29 -0700
wellsk40 at gmail.com wrote:

> +
> +	retval = request_irq(rtc->irq, lpc32xx_rtc_alarm_interrupt,
> +		IRQF_DISABLED, "rtcalarm", rtc);
> +	if (retval < 0) {
> +		dev_err(&pdev->dev, "Can't request interrupt\n");
> +		goto err_free_irq;
> +	}

 if the driver can work without the alarm irq you
 can convert this to a non fatal warning.

 having an rtc without alarms is much better than having none.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
