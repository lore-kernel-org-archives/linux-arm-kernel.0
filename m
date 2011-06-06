From: notasas@gmail.com (Grazvydas Ignotas)
Date: Mon, 6 Jun 2011 13:13:21 +0300
Subject: [PATCH 2/2] Remove old-style supply.dev assignments common in
	hsmmc init
In-Reply-To: <1307342762-25363-3-git-send-email-green@linuxhacker.ru>
References: <1307342762-25363-1-git-send-email-green@linuxhacker.ru>
	<1307342762-25363-3-git-send-email-green@linuxhacker.ru>
Message-ID: <BANLkTimgW+53CEfU8wNpaO8wPgWJ3yT90w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 6, 2011 at 9:46 AM,  <green@linuxhacker.ru> wrote:
> From: Oleg Drokin <green@linuxhacker.ru>
>
> CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
> CC: Mike Rapoport <mike@compulab.co.il>
> CC: Nishant Kamat <nskamat@ti.com>
> CC: Steve Sakoman <steve@sakoman.com>
> CC: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
> ---
> ?arch/arm/mach-omap2/board-cm-t35.c ? ? ? ? ? | ? ?2 --
> ?arch/arm/mach-omap2/board-ldp.c ? ? ? ? ? ? ?| ? ?2 --
> ?arch/arm/mach-omap2/board-omap3beagle.c ? ? ?| ? ?4 ----
> ?arch/arm/mach-omap2/board-omap3evm.c ? ? ? ? | ? ?4 ----
> ?arch/arm/mach-omap2/board-omap3logic.c ? ? ? | ? ?2 --
> ?arch/arm/mach-omap2/board-omap3stalker.c ? ? | ? ?4 ----
> ?arch/arm/mach-omap2/board-omap3touchbook.c ? | ? ?4 ----
> ?arch/arm/mach-omap2/board-overo.c ? ? ? ? ? ?| ? ?2 --
> ?arch/arm/mach-omap2/board-zoom-peripherals.c | ? ?7 -------
> ?9 files changed, 0 insertions(+), 31 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index 33855e4..a38cd70 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -480,8 +480,6 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
> ? ? ? ?omap2_hsmmc_init(mmc);
>
> ? ? ? ?/* link regulators to MMC adapters */

Would be useful to remove this comment too.

> - ? ? ? cm_t35_vmmc1_supply.dev = mmc[0].dev;
> - ? ? ? cm_t35_vsim_supply.dev = mmc[0].dev;
>
> ? ? ? ?return 0;
> ?}
