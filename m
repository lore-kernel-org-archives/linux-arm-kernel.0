From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Tue, 12 Jun 2018 14:42:12 +0200
Subject: [PATCH v7 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20180517055014.6607-4-o.rempel@pengutronix.de>
References: <20180517055014.6607-1-o.rempel@pengutronix.de>
 <20180517055014.6607-4-o.rempel@pengutronix.de>
Message-ID: <daba73df-037c-2583-3a08-f3f27c4129d1@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

Last version of this patch was send at 17.05.2018. No other comment was
provided and this patch is a blocker for other patches in this serie.
Can you please give some feedback on it.

On 17.05.2018 07:50, Oleksij Rempel wrote:
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
> index e4ced883d8de..83810d726f3e 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -49,6 +49,7 @@ int reboot_force;
>   */
>  
>  void (*pm_power_off_prepare)(void);
> +EXPORT_SYMBOL_GPL(pm_power_off_prepare);
>  
>  /**
>   *	emergency_restart - reboot the system
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180612/cf8a0197/attachment.sig>
