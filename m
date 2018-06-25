From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 25 Jun 2018 18:18:47 +0200 (CEST)
Subject: [PATCH 1/8] time: Add persistent clock support
In-Reply-To: <alpine.DEB.2.21.1806232224510.8650@nanos.tec.linutronix.de>
References: <cover.1528878545.git.baolin.wang@linaro.org>
 <d330f02c8ef2a348b179850e1745a52ab9c47e90.1528878545.git.baolin.wang@linaro.org>
 <alpine.DEB.2.21.1806232224510.8650@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1806251815320.1821@nanos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 24 Jun 2018, Thomas Gleixner wrote:
> The clocksource core already has all the registration/unregistration
> functionality plus an interface to reconfigure the frequency, so
> clocksources can come and go and be reconfigured and all of this just
> works.

Just for completeness sake.

If this extra suspend clocksource is not needed, i.e. because the system is
not suspended, then it does not need to be enabled. clocksources already
have an enable/disable callback exactly for that purpose. So instead of
having the clocks running during normal system operation the thing can be
OFF and save power and only be switched to ON when it is actually needed,
i.e. when going into suspend.

Thanks,

	tglx
