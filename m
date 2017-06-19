From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 19 Jun 2017 14:35:09 +0300
Subject: [PATCH v5 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20170619050245.2632-4-o.rempel@pengutronix.de>
References: <20170619050245.2632-1-o.rempel@pengutronix.de>
 <20170619050245.2632-4-o.rempel@pengutronix.de>
Message-ID: <1497872109.5380.10.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-06-19 at 07:02 +0200, Oleksij Rempel wrote:
> Export pm_power_off_prepare. It is needed to implement power off on
> Freescale/NXP iMX6 based boards with external power management
> integrated circuit (PMIC).
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> ?kernel/reboot.c | 1 +
> ?1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index bd30a973fe94..a6903bf772c7 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -49,6 +49,7 @@ int reboot_force;
> ? */
> ?
> ?void (*pm_power_off_prepare)(void);
> +EXPORT_SYMBOL(pm_power_off_prepare);
> ?
Could you register a reboot notifier in the pfuze driver instead? Right
now the only user of pm_power_off_prepare is ACPI so this alternative
seems less intrusive.

--
Regards,
Leonard
