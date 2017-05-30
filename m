From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 30 May 2017 17:47:44 +0300
Subject: [PATCHv3b 0/5] ARM: OMAP2+: preparation for clk/clkctrl support
Message-ID: <1496155669-1677-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is an alternative solution against v3 [1] of this series.

[1]?https://www.spinics.net/lists/arm-kernel/msg581965.html

This series is different in that it parses the hwmod data in the fly
and swaps the main_clk info with clkctrl implementations if those
are present. Patch #1 / #2 are old from v3 of the series, rest are
new. Patches #3 / #4 add some infrastructure support for parsing
the clock data, and patch #5 does the clock swapping.

With this series, it is not necessary to populate clkctrl clock
entries to DT at all, thus the transition should be smoother.

Integrated test branch for omap4 pushed here (contains 3 extra DT
patches on top.)

Tree: https://github.com/t-kristo/linux-pm.git
Branch: 4.12-rc1-clkctrl-integ-v3b

-Tero
