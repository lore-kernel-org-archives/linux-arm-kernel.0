From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Thu, 14 Jun 2012 16:24:39 +0530
Subject: [PATCH v2 0/4] ARM: OMAP2+: dmtimer: cleanup related to devm API
 and clk usage
In-Reply-To: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
References: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <CAC83ZvLOoUwthcv0seXeqJcuvxvhP7P500T66RHCCWvrsaPr2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 6:09 PM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:
> The devm API usage in probe() simplifies error handling operation.
> Since iclk is not used in the driver it is removed from wherever
> not needed.
> Corrected the timer fck name mis-match between clock44xx_data.c and
> omap_hwmod_44xx_data.c.
> Added omap_hwmod_get_main_clk() API. There is no more need to construct
> clock names using sprintf() to be used in clk_get() during initialization.
>
> Reference:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> Commit: e816b57a337ea3b755de72bec38c10c864f23015 (Linux 3.4-rc3)
>
> Series is available here for reference:
> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev dmtimer_cleanup_for_3.5
>
> Tested on following platforms:
> OMAP5, OMAP4430SDP, OMAP3430SDP, OMAP2430SDP.
> Could not test on OMAP2420 due to unavailability of board.
>
> v2:
> - Use devm_request_and_ioremap() instead of request_mem_region() and ioremap()
> - Add omap_hwmod_get_main_clk() API
> - Reverted changes of clock names from OMAP2 and OMAP3 platforms
>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Tarun Kanti DebBarma (4):
> ?ARM: OMAP: dmtimer: use devm_ API and do some cleanup in probe()
> ?ARM: OMAP2+: hwmod: add omap_hwmod_get_main_clk() API
> ?ARM: OMAP2+: dmtimer: cleanup iclk usage
> ?ARM: OMAP2+: dmtimer: cleanup fclk usage
[ping]
Only one of the patches in the series (ARM: OMAP2+: dmtimer: cleanup iclk usage)
has been taken. I just applied the remaining patches on top of Linux 3.5-rc2 and
tested on OMAP3 and OMAP4. Can the remaining patches be taken as well?
--
Tarun
>
> ?arch/arm/mach-omap2/clock44xx_data.c ? ? ? ? | ? 33 ++++++-----------
> ?arch/arm/mach-omap2/omap_hwmod.c ? ? ? ? ? ? | ? 15 ++++++++
> ?arch/arm/mach-omap2/timer.c ? ? ? ? ? ? ? ? ?| ? 10 +-----
> ?arch/arm/plat-omap/dmtimer.c ? ? ? ? ? ? ? ? | ? 51 ++++++++------------------
> ?arch/arm/plat-omap/include/plat/dmtimer.h ? ?| ? ?2 +-
> ?arch/arm/plat-omap/include/plat/omap_hwmod.h | ? ?2 +
> ?6 files changed, 46 insertions(+), 67 deletions(-)
>
