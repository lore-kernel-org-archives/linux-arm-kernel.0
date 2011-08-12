From: tony@atomide.com (Tony Lindgren)
Date: Fri, 12 Aug 2011 01:17:33 -0700
Subject: [PATCH v2] ARM: sched_clock: allow sched_clock to be selected
	at runtime
In-Reply-To: <1313078531-25610-1-git-send-email-marc.zyngier@arm.com>
References: <1313078531-25610-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110812081733.GQ1939@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [110811 08:29]:
> sched_clock() is yet another blocker on the road to the single
> image. This patch implements an idea by Russell King:
> 
> http://www.spinics.net/lists/linux-omap/msg49561.html
> 
> Instead of asking the platform to implement both sched_clock()
> itself and the rollover callback, simply register a read()
> function, and let the ARM code care about sched_clock() itself,
> the conversion to ns and the rollover. sched_clock() uses
> this read() function as an indirection to the platform code.
> 
> This allow some simplifications and possibly some footprint gain
> when multiple platforms are compiled in. Among the drawbacks,
> the removal of the *_fixed_sched_clock optimization which could
> negatively impact some platforms (sa1100, tegra, versatile
> and omap).

Nice! We were already struggling supporting various timers
in a single binary for omap for sched_clock.
 
> Tested on 11MPCore, OMAP4 and Tegra.

Will test on various omaps soonish.

Tony
