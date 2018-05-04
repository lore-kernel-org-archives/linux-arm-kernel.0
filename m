From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Fri, 4 May 2018 20:50:52 +0200
Subject: [PATCH v6 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20180305102524.5905-4-o.rempel@pengutronix.de>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
 <20180305102524.5905-4-o.rempel@pengutronix.de>
Message-ID: <20180504185052.bjhfkvpgrblc7tfc@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo Andrew,
I need your ACK or NACK for this patch.

This function is used to configure external PMIC to interpret
signal which will be triggered by pm_power_off as power off.
Since same signal can be used for stand by, I linked PMIC configuration
with pm_power_off_prepare to avoid possible conflicts.

On Mon, Mar 05, 2018 at 11:25:20AM +0100, Oleksij Rempel wrote:
> Export pm_power_off_prepare. It is needed to implement power off on
> Freescale/NXP iMX6 based boards with external power management
> integrated circuit (PMIC).
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  kernel/reboot.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index e4ced883d8de..350be6baa60d 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -49,6 +49,7 @@ int reboot_force;
>   */
>  
>  void (*pm_power_off_prepare)(void);
> +EXPORT_SYMBOL(pm_power_off_prepare);
>  
>  /**
>   *	emergency_restart - reboot the system
> -- 
> 2.16.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/1430215f/attachment.sig>
