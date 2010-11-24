From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Nov 2010 15:43:46 +0000
Subject: [PATCH 1/9] spi/pxa2xx: don't use subys initcall for driver init
In-Reply-To: <AANLkTikC+XW7JtJO77vQL99=d9FKpO2tLtkCuxE57j7o@mail.gmail.com>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>
	<1290597207-29838-2-git-send-email-bigeasy@linutronix.de>
	<AANLkTin4vh85XRkEd7YocCmKngViR_qZDe7z1b4JXyd-@mail.gmail.com>
	<4CED1C95.8070300@linutronix.de>
	<20101124141623.GH24970@rakim.wolfsonmicro.main>
	<AANLkTikC+XW7JtJO77vQL99=d9FKpO2tLtkCuxE57j7o@mail.gmail.com>
Message-ID: <20101124154346.GJ24970@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 08:30:37AM -0700, Grant Likely wrote:

> It would be easy enough to defer cpufreq initialization based on some
> platform defined criteria.  It's just an initcall.  However, I don't

Though it'd be much better to fix the thing where cpufreq doesn't have a
device anyway.

> know what the impact area is for subsystems that depend on cpufreq.
> Are there drivers that depend on cpufreq before initialized?

OMAP?  It'd be fairly surprising if something were to have a strict
dependency, though - more likely to be notifiers I'd expect.  Usually
cpufreq comes up fairly late.
