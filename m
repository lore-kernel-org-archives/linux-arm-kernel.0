From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Thu, 15 Oct 2015 15:30:50 -0300
Subject: [PATCH v3 0/4] mtd: pxa3xx_nand: rework the timing setup
In-Reply-To: <1444893451-16610-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1444893451-16610-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <CAAEAJfBdfc-=AH0z_A8-b70LH_=GJp0qPRp0zCohqDBf8pnokQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ccing Robert as he can provide valuable test on PXA boards.

On 15 October 2015 at 04:17, Antoine Tenart
<antoine.tenart@free-electrons.com> wrote:
> Hi all,
>
> Let's try one more time to get this merged.
>
> Another series, introducing the Berlin nand support, depends on this.
>
> This series was part of a bigger one[1], which was split into smaller
> ones as asked by Ezequiel[2]. When we take this into account, this is
> v8.
>
> The aim here is to use the nand framework to setup the timings,
> while keeping the old in-driver way of configuration timings for
> compatibility reasons.
>
> You can find the series at:
> https://github.com/atenart/linux.git berlin/4.3/nand-timings
>
> Antoine
>
> Since v2:
>         - Added back the support for keep-config 16 bits devices
>         - Fixed wrong unit in a calculation
>         - Reworked the pxa3xx_nand_init_timings() logic
>         - Allowed compile test the pxa3xx driver
>
> Since v1:
>         - Rebased on top of v4.2-rc1
>
> Since the series was split up:
>         - Reworked the ndcr setup
>         - Removed the read_id_bytes update after device detection
>
> Antoine Tenart (4):
>   mtd: nand: allow compile test of MTD_NAND_PXA3xx
>   mtd: pxa3xx_nand: add helpers to setup the timings
>   mtd: pxa3xx_nand: rework flash detection and timing setup
>   mtd: pxa3xx_nand: clean up the pxa3xx timings
>
>  drivers/mtd/nand/Kconfig                      |   2 +-
>  drivers/mtd/nand/pxa3xx_nand.c                | 273 ++++++++++++++++----------
>  include/linux/platform_data/mtd-nand-pxa3xx.h |  11 +-
>  3 files changed, 172 insertions(+), 114 deletions(-)
>
> --
> 2.6.1
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
