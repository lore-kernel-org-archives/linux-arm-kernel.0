From: agust@denx.de (Anatolij Gustschin)
Date: Mon, 7 Apr 2014 23:30:13 +0200
Subject: [PATCH] watchdog: imx2_wdt:  convert to watchdog core api
In-Reply-To: <20140407164811.GA28025@roeck-us.net>
References: <1396722580-7058-1-git-send-email-agust@denx.de>
 <20140407164811.GA28025@roeck-us.net>
Message-ID: <20140407233013.7e4b5195@crub>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Apr 2014 09:48:11 -0700
Guenter Roeck <linux@roeck-us.net> wrote:
...
> > +	if (val & IMX2_WDT_WCR_WDE)
> > +		return true;
> > +	return false;
> >  }
> 
> You can simplyfy this to
> 
> 	return val & IMX2_WDT_WCR_WDE;
> 
> since C auto-converts from int to bool. If you feel fancy and don't
> trust the C compiler, another option would be
> 
> 	return !!(val & IMX2_WDT_WCR_WDE);
> 
> which would at least drop the if statement.

I'll simplify it, yes.

> [ ... ]
> 
> > +
> > +	wdog->timeout = clamp_t(unsigned, timeout, 1, IMX2_WDT_MAX_TIME);
> > +	if (wdog->timeout != timeout)
> >  		dev_warn(&pdev->dev, "Initial timeout out of range! "
> > -			"Clamped from %u to %u\n", timeout, imx2_wdt.timeout);
> > +			"Clamped from %u to %u\n", timeout, wdog->timeout);
> 
> Somewhat unrelated, but this results in a checkpatch warning.
> I would suggest to put the string in a single line.
> 
> 		dev_warn(&pdev->dev,
> 			 "Initial timeout out of range! Clamped from %u to %u\n",
> 			 timeout, wdog->timeout);

okay, I'll fix the warning.

Thanks,
Anatolij
