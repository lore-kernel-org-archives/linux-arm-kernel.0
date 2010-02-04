From: a.zummo@towertech.it (Alessandro Zummo)
Date: Thu, 4 Feb 2010 10:42:22 +0100
Subject: [PATCH 1/2] Modify PL031 for Nomadik and U8500 v2
In-Reply-To: <1265273123-22421-1-git-send-email-linus.walleij@stericsson.com>
References: <1265273123-22421-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100204104222.1e7ae094@linux.lan.towertech.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  4 Feb 2010 09:45:23 +0100
Linus Walleij <linus.walleij@stericsson.com> wrote:

> This extends the existing PrimeCell PL031 driver with support for
> the ST Microelectronics and ST-Ericsson derivatives, in a first
> and second version as used on the Nomadik and U8500 platforms.
> It also rids the old ioctl() alarm on/off functions in favor of
> the new .alarm_irq_enable field of the RTC class ops.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

 Acked-by: Alessandro Zummo <a.zummo@towertech.it>


> If you Ack this Alessandro, is it OK that I put it in through
> Russells patch tracker and ARM tree?
 
 Ok. Be sure to have it tested on both versions
 of the rtc.

  Please also correct white lines between a function call
 and the related if:


> +	ret = pl031_stv2_tm_to_time(dev, tm, &time, &bcd_year);
----> +
> +	if (ret == 0) {
> +		writel(bcd_year, ldata->base + RTC_YLR);
> +		writel(time, ldata->base + RTC_LR);
> +	}

 I've seen a couple of those.


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
