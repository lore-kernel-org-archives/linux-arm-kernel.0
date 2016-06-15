From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jun 2016 12:41:09 +0200
Subject: [PATCH v2 6/6] i.MX: Do not explicitly call l2x0_of_init()
In-Reply-To: <1465954193-5894-7-git-send-email-andrew.smirnov@gmail.com>
References: <1465954193-5894-1-git-send-email-andrew.smirnov@gmail.com>
 <1465954193-5894-7-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <5355653.147Wd29CCq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 14, 2016 6:29:53 PM CEST Andrey Smirnov wrote:
>  DT_MACHINE_START(IMX35_DT, "Freescale i.MX35 (Device Tree Support)")
>         .map_io         = mx35_map_io,
>         .init_early     = imx35_init_early,
> -       .init_irq       = imx35_irq_init,
> +       .init_irq       = mx35_init_irq,
>         .dt_compat      = imx35_dt_board_compat,
> +       .l2c_aux_val    = 0,
> +       .l2c_aux_mask   = ~0,
>  MACHINE_END
> 

Please keep the fields sorted the same way that they are defined in
struct machine_desc, i.e. add the new fields at the top of this list.

Otherwise the whole series looks good to me now,

Acked-by: Arnd Bergmann <arnd@arndb.de>
