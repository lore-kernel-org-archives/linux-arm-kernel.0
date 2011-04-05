From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Apr 2011 00:22:15 +0200
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <4D9AB958.5010304@ti.com>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
	<201104031726.37420.arnd@arndb.de>
	<20110403160324.GA8050@n2100.arm.linux.org.uk>
	<201104040259.26601.arnd@arndb.de>
	<1301915022.15819.28.camel@e102109-lin.cambridge.arm.com>
	<20110404112104.GB19854@n2100.arm.linux.org.uk>
	<1301923457.417.34.camel@e102391-lin.cambridge.arm.com>
	<20110404133104.GA23266@n2100.arm.linux.org.uk>
	<1301925445.417.54.camel@e102391-lin.cambridge.arm.com>
	<BANLkTi=d-rQpinSW9YPsZbkh9tDK5FLS+w@mail.gmail.com>
	<4D9AB958.5010304@ti.com>
Message-ID: <BANLkTins_YaNYSRc1ryZuRSnGKO2MEemuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/5 Santosh Shilimkar <santosh.shilimkar@ti.com>:

> The only issue I see is the clock-events implemented using
> local timers capabilities in low power modes. The local timers
> won't be able wakeup CPU from DORMANT or OFF state and hence
> you will need an additional wakeup capable clock-event
> working together with the local timers using clock-notifiers.

And this is because the IRQs it emits are local and thus cannot wake
the system? This sounds way backwards... A simple na?ve solution
would have been to just route out an external IRQ line back from a
selected timer and into the GIC so it will be able to wake up the
system, right?

Yours,
Linus Walleij
