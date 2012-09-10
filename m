From: tony@atomide.com (Tony Lindgren)
Date: Mon, 10 Sep 2012 11:39:44 -0700
Subject: [PATCH] ARM: OMAP2+: mux: add support for PAD wakeup event handler
In-Reply-To: <1347273528-2056-1-git-send-email-ruslan.bilovol@ti.com>
References: <1347273528-2056-1-git-send-email-ruslan.bilovol@ti.com>
Message-ID: <20120910183943.GA1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ruslan Bilovol <ruslan.bilovol@ti.com> [120910 03:39]:
> OMAP mux now parses active wakeup events from pad registers and calls
> corresponding handler, if handler is not registered - corresponding
> hwmod ISRs once a wakeup is detected.
> This is useful for cases when routing wakeups to corresponding hwmod
> ISRs complicates those ISRs handlers (for example, ISR handler may
> not know who the interrupt source is)

The mux code in arch/arm/mach-omap2 will be going away and replaced
by device tree based pinctrl-single. It's not a good idea to add more
dependencies to custom frameworks as that just makes the transition
harder on us.

Regards,

Tony
