From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 30 Sep 2010 15:09:22 +0400
Subject: [PATCH 1/6] mmc: sdhci-pltfm: Add structure for host-specific data
In-Reply-To: <20100930101938.GE2655@pengutronix.de>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
	<1285790884-3516-2-git-send-email-w.sang@pengutronix.de>
	<4CA3AE89.2030107@pelagicore.com>
	<20100930081605.GA2655@pengutronix.de>
	<4CA45E6D.4070308@pelagicore.com>
	<20100930101938.GE2655@pengutronix.de>
Message-ID: <20100930110922.GA8464@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 30, 2010 at 12:19:38PM +0200, Wolfram Sang wrote:
[...]
> > You're right it wouldn't. But isn't it a bit risky even if you could access it,
> > in the long the platform_data coild point to something that is in the __devinit section
> > or similar?
> 
> The use-case we see now is in the custom init() call, i.e. setting up
> GPIO, enabling clocks. That is in the same section. Accessing
> platform_data later is in deed always risky and should not be done,
> sdhci-pltfm is no special case here.

I don't think that it's always risky, it's more driver-specific.

Many drivers access it from everywhere, see drivers/mmc/host/mmc_spi.c
for example. In general, if the driver needs most of the platform data
in the run-time, it makes no sense to duplicate or copy the pdata into
the private struct field by field.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
