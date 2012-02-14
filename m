From: khilman@ti.com (Kevin Hilman)
Date: Tue, 14 Feb 2012 12:02:06 -0800
Subject: [PATCH 0/6] arm: omap: clk/clkdm/pwrdm/voltdm changes to
 usecounting
In-Reply-To: <1329237402-26008-1-git-send-email-t-kristo@ti.com> (Tero
 Kristo's message of "Tue, 14 Feb 2012 18:36:36 +0200")
References: <1329237402-26008-1-git-send-email-t-kristo@ti.com>
Message-ID: <87ty2t5gld.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> This set is split out from a larger set earlier circulated on linux-omap
> list. The main purpose of this set is to provide useful recursive
> usecounting support for clockdomains / powerdomains / voltagedomains
> which can be used for debugging purposes and also to control certain
> chip power features once a sleep condition is reached (voltdm usecount=0).
>
> This set provides only the baseline support for the usecounting, and also
> adds a pm-debug related patch that can be used to check out stuff (patch 6),
> and should later prove rather useful for debugging. Rest of the
> functionality will be posted in separate sets.
>
> This set has been tested on omap3 beagle board with suspend / resume /
> cpuidle. Also boot tested on omap4 panda (sleep is not functional yet
> on that platform.)

This is a great series, and results in pm_debug debugfs data that's
actually useful for real debug.  Thanks!

I had a minor comment on the idle path changes, but all the other stuff
is

Acked-by: Kevin Hilman <khilman@ti.com>

Paul, this should probably merge via you (when it's ready) since the
important changes are clock and powerdomain core changes.

Kevin
