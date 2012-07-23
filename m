From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 23 Jul 2012 11:20:25 +0200
Subject: [PATCH 25/25] can: mpc5xxx_can: make data used as
 *of_device_id.data const
In-Reply-To: <1343034810-3386-26-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-26-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <500D1759.4040002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2012 11:13 AM, Uwe Kleine-K?nig wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> [ukl: split Arnd's patch by driver]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

> ---
>  drivers/net/can/mscan/mpc5xxx_can.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
> index 06adf88..8a8df82 100644
> --- a/drivers/net/can/mscan/mpc5xxx_can.c
> +++ b/drivers/net/can/mscan/mpc5xxx_can.c
> @@ -380,12 +380,12 @@ static int mpc5xxx_can_resume(struct platform_device *ofdev)
>  }
>  #endif
>  
> -static struct mpc5xxx_can_data __devinitdata mpc5200_can_data = {
> +static const struct mpc5xxx_can_data __devinitdata mpc5200_can_data = {
>  	.type = MSCAN_TYPE_MPC5200,
>  	.get_clock = mpc52xx_can_get_clock,
>  };
>  
> -static struct mpc5xxx_can_data __devinitdata mpc5121_can_data = {
> +static const struct mpc5xxx_can_data __devinitdata mpc5121_can_data = {
>  	.type = MSCAN_TYPE_MPC5121,
>  	.get_clock = mpc512x_can_get_clock,
>  };
> 

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120723/afe9dcd6/attachment-0001.sig>
