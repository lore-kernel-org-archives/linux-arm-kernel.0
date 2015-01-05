From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 05 Jan 2015 21:25:17 +0100
Subject: [PATCH v11 1/9] ARM: OMAP2+: use common l2cache initialization
 code
In-Reply-To: <1420460348-20302-2-git-send-email-m.szyprowski@samsung.com>
References: <1420460348-20302-1-git-send-email-m.szyprowski@samsung.com>
 <1420460348-20302-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <2975078.sXsfBJkaoi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 January 2015 13:19:00 Marek Szyprowski wrote:
>  DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
> +       .l2c_aux_val    = OMAP_L2C_AUX_CTRL,
> +       .l2c_aux_mask   = 0xcf9fffff,
> +       .l2c_write_sec  = omap4_l2c310_write_sec,
>         .reserve        = omap_reserve,
>         .smp            = smp_ops(omap4_smp_ops),
>         .map_io         = omap4_map_io,
> 

Could we also get those values into the dts files? Clearly we
can't remove them here without breaking compatibility with old
dtbs, but it would be nice to have all new dtbs do the right thing.

	Arnd
