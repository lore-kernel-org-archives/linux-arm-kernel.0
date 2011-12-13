From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 13 Dec 2011 14:22:34 +0100
Subject: [PATCH v4] ARM: sched_clock: allow sched_clock to be selected at
 runtime
In-Reply-To: <1323444833-10587-1-git-send-email-marc.zyngier@arm.com> (Marc
 Zyngier's message of "Fri, 9 Dec 2011 15:33:53 +0000")
References: <1323444833-10587-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <m3y5ugip2d.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier <marc.zyngier@arm.com> writes:

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
> If the platform doesn't provide a read(), the code falls back
> to the jiffy counter (just like the default sched_clock).
>
> This allow some simplifications and possibly some footprint gain
> when multiple platforms are compiled in. Among the drawbacks,
> the removal of the *_fixed_sched_clock optimization which could
> negatively impact some platforms (sa1100, tegra, versatile
> and omap).
>
> Tested on 11MPCore, OMAP4 and Tegra.

The IXP4xx part looks good to me,
Acked-By: Krzysztof Halasa <khc@pm.waw.pl>
-- 
Krzysztof Halasa
