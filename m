From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 14 Feb 2012 18:36:36 +0200
Subject: [PATCH 0/6] arm: omap: clk/clkdm/pwrdm/voltdm changes to usecounting
Message-ID: <1329237402-26008-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set is split out from a larger set earlier circulated on linux-omap
list. The main purpose of this set is to provide useful recursive
usecounting support for clockdomains / powerdomains / voltagedomains
which can be used for debugging purposes and also to control certain
chip power features once a sleep condition is reached (voltdm usecount=0).

This set provides only the baseline support for the usecounting, and also
adds a pm-debug related patch that can be used to check out stuff (patch 6),
and should later prove rather useful for debugging. Rest of the
functionality will be posted in separate sets.

This set has been tested on omap3 beagle board with suspend / resume /
cpuidle. Also boot tested on omap4 panda (sleep is not functional yet
on that platform.)

Applies on mainline kernel.

-Tero
