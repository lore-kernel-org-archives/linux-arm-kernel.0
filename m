From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Aug 2014 09:01:50 +0200
Subject: [PATCH v2 1/5] ARM: BCM63XX: add basic support for the Broadcom
 BCM63138 DSL SoC
In-Reply-To: <1408061487-20984-2-git-send-email-f.fainelli@gmail.com>
References: <1408061487-20984-1-git-send-email-f.fainelli@gmail.com>
 <1408061487-20984-2-git-send-email-f.fainelli@gmail.com>
Message-ID: <3533813.fmr1R5OBqN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 August 2014 17:11:23 Florian Fainelli wrote:
> +static void __init bcm63xx_init(void)
> +{
> +       of_platform_populate(NULL, of_default_bus_match_table, NULL,
> +               &platform_bus);
> +       l2x0_of_init(0, ~0);
> +}
> +
> +static const char * const bcm63xx_dt_compat[] = {
> +       "brcm,bcm63138",
> +       NULL
> +};
> +
> +DT_MACHINE_START(BCM63XXX_DT, "BCM63xx DSL SoC")
> +       .init_machine   = bcm63xx_init,
> +       .dt_compat      = bcm63xx_dt_compat,
> +MACHINE_END
> 

You should be able to remove that bcm63xx_init() function if you add
the l2c_aux_val/l2c_aux_mask settings in the machine descriptor
instead.

	Arnd
