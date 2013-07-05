From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 5 Jul 2013 08:30:47 +0200 (CEST)
Subject: [PATCH] clocksource/cadence_ttc: Reuse clocksource as sched_clock
In-Reply-To: <1372888216-10726-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1372888216-10726-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <alpine.DEB.2.02.1307050819000.11637@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 3 Jul 2013, Soren Brinkmann wrote:

> Reuse the TTC clocksource timer as sched clock, too. Since only a single
> sched clock is supported in Linux, this feature optional and can be
> selected through Kconfig.

This changelog doesn't make sense.

There can be only one active sched_clock, but that does no mean, that
you cannot have different implementations compiled in.

So if you disable this config which sched_clock is your kernel using?
And if you enable it, how is guaranteed that you end up with the ttc
sched_clock as the active one? Just due to initcall ordering?

Thanks,

	tglx
