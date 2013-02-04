From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Sun, 3 Feb 2013 23:24:26 -0700
Subject: [PATCH] rtc: rtc-mv: Add support for clk to avoid lockups
In-Reply-To: <20130203111415.GE27791@lunn.ch>
References: <1359887453-17189-1-git-send-email-andrew@lunn.ch>
 <20130203111055.GA29236@schnuecks.de>
 <20130203111415.GE27791@lunn.ch>
Message-ID: <20130204062426.GB7115@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 03, 2013 at 12:14:15PM +0100, Andrew Lunn wrote:
> > > +	pdata->clk = devm_clk_get(&pdev->dev, NULL);
> > > +	/* Not all SoCs require a clock.*/
> > > +	if (!IS_ERR(pdata->clk))
> > > +		clk_prepare_enable(pdata->clk);
> > > +
> > 
> > There are already I/O accesses to the RTC above this. Thus, you
> > probably need to move this up.
> 
> Doh!
> 
> I was trying to keep the cleanup on error simple....

Why is this stuff in the drivers anyhow? All the other kernel power
management seems to be done by the device core prior to probing the
device, why is clk different?

Jason
