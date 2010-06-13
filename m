From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 14 Jun 2010 00:02:22 +0800
Subject: [PATCH 2/2] [ARM] pxa/cm-x300: enable the IRQ_WAKEUP0 as wakeup
	source.
In-Reply-To: <1276417909-22980-3-git-send-email-grinberg@compulab.co.il>
References: <1276417909-22980-1-git-send-email-grinberg@compulab.co.il>
	<1276417909-22980-2-git-send-email-grinberg@compulab.co.il>
	<1276417909-22980-3-git-send-email-grinberg@compulab.co.il>
Message-ID: <AANLkTilhqoMa3qsPEYyVWKJrPHl5NnKWUhzexhPjEZaZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 13, 2010 at 4:31 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>

OK, applied.

> ---
> ?arch/arm/mach-pxa/cm-x300.c | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
> index fdda6be..8d227b4 100644
> --- a/arch/arm/mach-pxa/cm-x300.c
> +++ b/arch/arm/mach-pxa/cm-x300.c
> @@ -689,6 +689,7 @@ static void __init cm_x300_init_da9030(void)
> ?{
> ? ? ? ?pxa3xx_set_i2c_power_info(&cm_x300_pwr_i2c_info);
> ? ? ? ?i2c_register_board_info(1, &cm_x300_pmic_info, 1);
> + ? ? ? set_irq_wake(IRQ_WAKEUP0, 1);
> ?}
>
> ?static void __init cm_x300_init_wi2wi(void)
> --
> 1.6.4.4
>
>
