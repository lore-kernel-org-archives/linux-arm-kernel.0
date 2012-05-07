From: khilman@ti.com (Kevin Hilman)
Date: Mon, 07 May 2012 10:33:41 -0700
Subject: [PATCH 0/2] ARM: OMAP3: cleanup AM35xx SoC detection
In-Reply-To: <1335829030-19431-1-git-send-email-khilman@ti.com> (Kevin
 Hilman's message of "Mon, 30 Apr 2012 16:37:08 -0700")
References: <1335829030-19431-1-git-send-email-khilman@ti.com>
Message-ID: <87zk9j5216.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Kevin Hilman <khilman@ti.com> writes:

> The detection of AM35xx SoCs is confusing and has redundancies.  Clean
> this up so that SoC detection is only based on SoC family: AM35xx.

Since these aren't PM related, can you queue these with other cleanups
for v3.5.  This is now independent from the similar changes made to the
clock fwk which Paul is queuing.

Once both series are merged, I'll have one final patch that removes all
users of cpu_is_omap35*.

Kevin

> Kevin Hilman (2):
>   ARM: OMAP: AM35xx: remove redunant cpu_is checks for AM3505
>   ARM: OMAP: AM35xx: convert 3517 detection/flags to AM35xx
>
>  arch/arm/mach-omap2/hsmmc.c                   |    8 ++++----
>  arch/arm/mach-omap2/id.c                      |    7 +++----
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    2 +-
>  arch/arm/mach-omap2/powerdomains3xxx_data.c   |    2 +-
>  arch/arm/mach-omap2/usb-musb.c                |    2 +-
>  arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 +-
>  arch/arm/plat-omap/include/plat/cpu.h         |    8 ++++++++
>  7 files changed, 19 insertions(+), 12 deletions(-)
