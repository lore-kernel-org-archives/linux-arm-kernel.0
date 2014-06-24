From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 24 Jun 2014 08:09:14 -0300
Subject: [PATCH] ARM: imx53: globally disable supervisor protect
In-Reply-To: <1403605229-29623-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1403605229-29623-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <CAOMZO5AYeCGHaONawxDbepGCG_2ez810TFxc_5TzC_SNhqOn5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 7:20 AM, Steffen Trumtrar
<s.trumtrar@pengutronix.de> wrote:

> diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
> index 2bad387..4d3e750 100644
> --- a/arch/arm/mach-imx/mach-imx53.c
> +++ b/arch/arm/mach-imx/mach-imx53.c
> @@ -29,6 +29,8 @@ static void __init imx53_dt_init(void)
>         mxc_arch_reset_init_dt();
>
>         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +
> +       imx_set_aips(MX53_IO_ADDRESS(MX53_AIPS2_BASE_ADDR));

Please retrieve the base address via dt.

MX53_IO_ADDRESS has gone away in linux-next.
