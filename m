From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 12:16:21 +0000
Subject: [PATCH 04/04] ARM: shmobile: APE6EVM support
In-Reply-To: <20130312045637.19701.62477.sendpatchset@w520>
References: <20130312045559.19701.77841.sendpatchset@w520>
 <20130312045637.19701.62477.sendpatchset@w520>
Message-ID: <201303121216.21953.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 March 2013, Magnus Damm wrote:
> +
> +static const char *ape6evm_boards_compat_dt[] __initdata = {
> +       "renesas,ape6evm",
> +       NULL,
> +};
> +
> +DT_MACHINE_START(APE6EVM_DT, "ape6evm")
> +       .init_irq       = irqchip_init,
> +       .init_time      = shmobile_timer_init,
> +       .init_machine   = r8a73a4_add_standard_devices,
> +       .dt_compat      = ape6evm_boards_compat_dt,
> +MACHINE_END

Do you plan to add board-specific contents here in a follow-up patch soon?

If not, it seems the setup-r8a73a4.c already handles this board with its
defaults.

	Arnd
