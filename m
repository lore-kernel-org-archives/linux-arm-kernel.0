From: notasas@gmail.com (Grazvydas Ignotas)
Date: Wed, 13 Jul 2011 13:48:08 +0300
Subject: [PATCH V2 00/16] omap_hsmmc patches
In-Reply-To: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
Message-ID: <CANOLnONWmYn4FpuF-UAKQR4rAA6LOgWdMfu2bMN46nna6rOxAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

it seems this series got lost in time, at least patches 01, 02, 03,
04, 05, 06, 07, 08, 12 look like valid standalone fixes and
improvements to me, they don't touch other trees and still apply
cleanly, so would be good to have.

Chris, can you queue these for upcoming merge window?
These patches are also archived in patchwork here:
https://patchwork.kernel.org/project/linux-omap/list/?archive=both&page=8


On Fri, May 6, 2011 at 12:13 PM, Adrian Hunter <adrian.hunter@nokia.com> wrote:
> Hi
>
> Here is V2 of some patches for omap_hsmmc.
>
> Changes in V2:
>
> ? ? ? ?OMAP: sDMA: descriptor autoloading feature
> ? ? ? ? ? ? ? ?- removed the feature entirely as per Tony Lindgren
>
> ? ? ? ?mmc: omap_hsmmc: fix few bugs when set the clock divisor
> ? ? ? ? ? ? ? ?- added cpu_relax() as per Grazvydas Ignotas
>
> ? ? ? ?mmc: omap_hsmmc: fix missing mmc_release_host() in no_off case
> ? ? ? ? ? ? ? ?- removed {} as per Sergei Shtylyov
>
> ? ? ? ?OMAP: hsmmc: implement clock switcher
> ? ? ? ? ? ? ? ?- changed to >= threshold as per Grazvydas Ignotas
>
>
> Adrian Hunter (6):
> ? ? ?mmc: omap_hsmmc: correct debug report error status mnemonics
> ? ? ?OMAP: board-rm680: set MMC nomux flag
> ? ? ?mmc: omap_hsmmc: ensure pbias configuration is always done
> ? ? ?mmc: omap_hsmmc: fix oops in omap_hsmmc_dma_cb
> ? ? ?OMAP: hsmmc: add platform data for eMMC hardware reset gpio
> ? ? ?mmc: omap_hsmmc: add a hardware reset before initialization
>
> Andy Shevchenko (8):
> ? ? ?mmc: omap_hsmmc: move hardcoded frequency constants to definition block
> ? ? ?mmc: omap_hsmmc: reduce a bit the error handlers in probe()
> ? ? ?mmc: omap_hsmmc: split duplicate code to calc_divisor() function
> ? ? ?mmc: omap_hsmmc: introduce start_clock and re-use stop_clock
> ? ? ?mmc: omap_hsmmc: fix few bugs when set the clock divisor
> ? ? ?mmc: omap_hsmmc: split same pieces of code to separate functions
> ? ? ?OMAP: hsmmc: implement clock switcher
> ? ? ?mmc: omap_hsmmc: adjust host controller clock in regard to current OPP
>
> Jarkko Lavinen (1):
> ? ? ?OMAP: hsmmc: Do not mux the slot if non default muxing is already done
>
> Sudhir Bera (1):
> ? ? ?mmc: omap_hsmmc: fix missing mmc_release_host() in no_off case
>
> ?arch/arm/mach-omap2/board-rm680.c ? ? | ? ?1 +
> ?arch/arm/mach-omap2/hsmmc.c ? ? ? ? ? | ?188 +++++++++++++++++-
> ?arch/arm/mach-omap2/hsmmc.h ? ? ? ? ? | ? ?2 +
> ?arch/arm/plat-omap/include/plat/mmc.h | ? ?9 +
> ?drivers/mmc/host/omap_hsmmc.c ? ? ? ? | ?353 ++++++++++++++++++++-------------
> ?5 files changed, 414 insertions(+), 139 deletions(-)
>
> Regards
> Adrian
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>

-- 
Gra?vydas
