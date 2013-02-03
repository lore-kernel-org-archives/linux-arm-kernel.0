From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 3 Feb 2013 12:14:15 +0100
Subject: [PATCH] rtc: rtc-mv: Add support for clk to avoid lockups
In-Reply-To: <20130203111055.GA29236@schnuecks.de>
References: <1359887453-17189-1-git-send-email-andrew@lunn.ch>
 <20130203111055.GA29236@schnuecks.de>
Message-ID: <20130203111415.GE27791@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +	pdata->clk = devm_clk_get(&pdev->dev, NULL);
> > +	/* Not all SoCs require a clock.*/
> > +	if (!IS_ERR(pdata->clk))
> > +		clk_prepare_enable(pdata->clk);
> > +
> 
> There are already I/O accesses to the RTC above this. Thus, you
> probably need to move this up.

Doh!

I was trying to keep the cleanup on error simple....

Thanks
	Andrew
