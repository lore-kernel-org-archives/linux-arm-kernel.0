From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 3 Nov 2012 17:37:36 +0530
Subject: [PATCH v3 02/11] clk: davinci - add PSC clock driver
In-Reply-To: <1351181518-11882-3-git-send-email-m-karicheri2@ti.com>
References: <1351181518-11882-1-git-send-email-m-karicheri2@ti.com>
 <1351181518-11882-3-git-send-email-m-karicheri2@ti.com>
Message-ID: <50950908.1060302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2012 9:41 PM, Murali Karicheri wrote:
> This is the driver for the Power Sleep Controller (PSC) hardware
> found on DM SoCs as well Keystone SoCs (c6x). This driver borrowed
> code from arch/arm/mach-davinci/psc.c and implemented the driver
> as per common clock provider API. The PSC module is responsible for
> enabling/disabling the Power Domain and Clock domain for different IPs
> present in the SoC. The driver is configured through the clock data
> passed to the driver through struct clk_psc_data.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---

> +/**
> + * struct clk_psc - DaVinci PSC clock driver data
> + *
> + * @hw: clk_hw for the psc
> + * @psc_data: Driver specific data
> + */
> +struct clk_psc {
> +	struct clk_hw hw;
> +	struct clk_psc_data *psc_data;

> +	spinlock_t *lock;

Unused member? I don't see this being used.

Thanks,
Sekhar
