From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 May 2014 11:30:15 +0200
Subject: [PATCH v2 3/4] arm: add basic support for Mediatek MT6589 boards
In-Reply-To: <1399772463-859-4-git-send-email-matthias.bgg@gmail.com>
References: <1399772463-859-1-git-send-email-matthias.bgg@gmail.com>
 <1399772463-859-4-git-send-email-matthias.bgg@gmail.com>
Message-ID: <80525303.7Oax6ZBozr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 May 2014 03:41:02 Matthias Brugger wrote:
> +
> +static void __init mediatek_dt_init(void)
> +{
> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}
> +
> +static const char * const mediatek_board_dt_compat[] = {
> +       "mediatek,mt6589",
> +       NULL,
> +};
> +
> +DT_MACHINE_START(MEDIATEK_DT, "Mediatek Cortex-A7 (Device Tree)")
> +       .init_machine   = mediatek_dt_init,
> +       .dt_compat      = mediatek_board_dt_compat,
> +MACHINE_END

Since the mediatek_dt_init function now only does the default populate
call, you can leave it out completely and keep only the compat list.

	Arnd
