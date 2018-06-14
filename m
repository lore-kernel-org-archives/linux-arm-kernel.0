From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 14 Jun 2018 10:30:56 +0200
Subject: [PATCH v2] net: ethernet: stmmac: dwmac-rk: Add GMAC support for
 PX30
In-Reply-To: <3aa2445f-ab2a-93b6-3a49-36be6c98d327@rock-chips.com>
References: <1528956927-32440-1-git-send-email-david.wu@rock-chips.com>
 <1961033.25ax7s0Z5i@diego>
 <3aa2445f-ab2a-93b6-3a49-36be6c98d327@rock-chips.com>
Message-ID: <2582999.2hZx6CH9S6@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 14. Juni 2018, 10:14:31 CEST schrieb David Wu:
> Hi Heiko,
> 
> ? 2018?06?14? 15:54, Heiko St?bner ??:
> > I don't see that new clock documented in the dt-binding.
> > Also, which clock from the clock-controller does this connect to?
> 
> The clock is the "SCLK_GMAC_RMII" at the clock-controller, which could
> be set rate by the link speed.

Hmm, while these huge number of clocks are somewhat strange,
shouldn't it be named something with _rmii instead of _speed then?

Also, I don't see any clk_enable action for that new clock, so you could
end up with being off?

And someone could convert the driver to use the new clk-bulk APIs [0],
so the large number of clk_prepare_enable calls would be a bit
trimmed down.


Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk-bulk.c
