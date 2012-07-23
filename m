From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 23 Jul 2012 11:17:49 +0200
Subject: [PATCH 18/25] can: mpc5xxx_can: make data in mpc5xxx_can_probe
 const
In-Reply-To: <1343034810-3386-19-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-19-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <500D16BD.2080900@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2012 11:13 AM, Uwe Kleine-K?nig wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Note: this patch is already upstream in David Miller's net-next tree.
0e84eb0 can: mpc5xxx_can: make data in mpc5xxx_can_probe const

cheers, Marc
> ---
>  drivers/net/can/mscan/mpc5xxx_can.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
> index 5caa572..06adf88 100644
> --- a/drivers/net/can/mscan/mpc5xxx_can.c
> +++ b/drivers/net/can/mscan/mpc5xxx_can.c
> @@ -251,7 +251,7 @@ static struct of_device_id mpc5xxx_can_table[];
>  static int __devinit mpc5xxx_can_probe(struct platform_device *ofdev)
>  {
>  	const struct of_device_id *match;
> -	struct mpc5xxx_can_data *data;
> +	const struct mpc5xxx_can_data *data;
>  	struct device_node *np = ofdev->dev.of_node;
>  	struct net_device *dev;
>  	struct mscan_priv *priv;
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120723/63d43310/attachment-0001.sig>
