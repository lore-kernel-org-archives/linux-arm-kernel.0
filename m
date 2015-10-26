From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Mon, 26 Oct 2015 10:50:33 -0300
Subject: [PATCH v4 0/5] mtd: pxa3xx_nand: rework the timing setup
In-Reply-To: <1445416144-9194-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1445416144-9194-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20151026135033.GA1820@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 Oct 10:28 AM, Antoine Tenart wrote:
> Hello,
> 
> Let's try one more time to get this merged.
> 
> This series was part of a bigger one[1], which was split into smaller
> ones as asked by Ezequiel[2]. When we take this into account this is
> v9; with a v1 sent in January, 9 months ago.
> 
> Another series, introducing the Berlin nand support, depends on this.
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
> Since v3:
>         - Moved back a chunk into the right patch.
>         - Called pxa3xx_nand_config_flash() before KEEP_CONFIG.
>         - Rebased on top of l2-mtd.git master.
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
> Antoine Tenart (5):
>   mtd: pxa3xx: prepare allowing compile test

Nit: This commit subject sounds a bit off.

>   mtd: nand: allow compile test of MTD_NAND_PXA3xx
>   mtd: pxa3xx_nand: add helpers to setup the timings
>   mtd: pxa3xx_nand: rework flash detection and timing setup
>   mtd: pxa3xx_nand: clean up the pxa3xx timings
> 
>  drivers/mtd/nand/Kconfig       |   2 +-
>  drivers/mtd/nand/pxa3xx_nand.c | 274 +++++++++++++++++++++++++----------------
>  2 files changed, 168 insertions(+), 108 deletions(-)
> 

The series look good and it's certainly a great improvement.
Thomas and Robert tested it, so we should be good to go:

Acked-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

We can take a look at the timeout reported by Thomas afterwards.

BTW, it would be great if you could post a patch using Boris'
timings helpers: https://patchwork.ozlabs.org/patch/534919/ ?
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
