From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Nov 2014 15:23:14 +0100
Subject: [PATCH 2/4] ARM: shmobile: r8a7740: Migrate to generic l2c OF
 initialization
In-Reply-To: <1416232388-2611-3-git-send-email-geert+renesas@glider.be>
References: <1416232388-2611-1-git-send-email-geert+renesas@glider.be>
 <1416232388-2611-3-git-send-email-geert+renesas@glider.be>
Message-ID: <1829825.nytgIBNlTf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 November 2014 14:53:06 Geert Uytterhoeven wrote:
>  DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
> +       /* Shared attribute override enable, 32K*8way */
> +       .l2c_aux_val    = 0x00400000,
> +       .l2c_aux_mask   = 0xc20f0fff,
>         .map_io         = r8a7740_map_io,
>         .init_early     = shmobile_init_delay,
>         .init_irq       = r8a7740_init_irq_of,

You are only now adding it to DT, so you should have enough freedom
to put the correct values in it.

Please use the 0/0xffffffff settings here and use the generic
code to set up the L2X0.

	Arnd
