From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 10 Jan 2012 11:13:11 +0000
Subject: [PATCH v6 5/9] ARM: vexpress: Add Device Tree support
In-Reply-To: <1323957761-13553-6-git-send-email-pawel.moll@arm.com>
References: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>
 <1323957761-13553-6-git-send-email-pawel.moll@arm.com>
Message-ID: <1326193991.2107.8.camel@linaro1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-12-15 at 14:02 +0000, Pawel Moll wrote:
> This patch adds generic Versatile Express DT machine description,
> Device Tree description for the motherboard and documentation for
> the bindings.
[...]
> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
[...]
> +DT_MACHINE_START(VEXPRESS_DT, "ARM Versatile Express")
> +	.map_io		= v2m_dt_map_io,
> +	.init_early	= v2m_dt_init_early,
> +	.init_irq	= v2m_dt_init_irq,
> +	.timer		= &v2m_dt_timer,
> +	.init_machine	= v2m_dt_init,
> +	.dt_compat	= v2m_dt_match,
> +MACHINE_END

The machine name here is missing a '-' that is in the original non
device-tree machine description, which is "ARM-Versatile Express".
The hyphen is also in Integrator and Realview machine names, so this
seems to be a convention with ARM boards.

(I found this because Android parses machine name for configuration
purposes.)

-- 
Tixy
