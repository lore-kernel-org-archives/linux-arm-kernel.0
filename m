From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 4 Feb 2014 17:24:37 +0100 (CET)
Subject: [PATCH v4 1/3] clocksource: timer-keystone: introduce clocksource
 driver for Keystone
In-Reply-To: <1391513453-21140-2-git-send-email-ivan.khoronzhuk@ti.com>
References: <1391513453-21140-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1391513453-21140-2-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <alpine.DEB.2.02.1402041715220.24986@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Feb 2014, Ivan Khoronzhuk wrote:
> +	keystone_timer_writel(off, TCR);
> +	/* here we have to be sure the timer has been disabled */
> +	wmb();

We have explicit writew_relaxed and writew. Why open coding the
barriers?

Thanks,

	tglx
