From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 14 May 2015 17:38:02 +0200
Subject: [PATCH v2 3/5] can: flexcan: Add ls1021a flexcan device entry
In-Reply-To: <1431603215-25546-4-git-send-email-bhupesh.sharma@freescale.com>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
 <1431603215-25546-4-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <5554C15A.6050501@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2015 01:33 PM, Bhupesh Sharma wrote:
> This patch adds ls1021a flexcan device entry to the flexcan driver code.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> ---
>  drivers/net/can/flexcan.c |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index ad0a7e8..deaa24e 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -267,10 +267,26 @@ static struct flexcan_devtype_data fsl_imx28_devtype_data;
>  static struct flexcan_devtype_data fsl_imx6q_devtype_data = {
>  	.features = FLEXCAN_HAS_V10_FEATURES,
>  };
> +
>  static struct flexcan_devtype_data fsl_vf610_devtype_data = {
>  	.features = FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_MECR_FEATURES,
>  };
>  
> +/* LS1021A-Rev1 has a broken RX-FIFO support. So only legacy RX message-buffers
> + * work here.
> + */
> +static struct flexcan_devtype_data fsl_ls1021a_devtype_data = {
> +	.features = FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_MECR_FEATURES |
> +		    FLEXCAN_HAS_ONLY_LEGACY_RX_SUPPORT,
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This will probably not compile.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150514/f82e8ded/attachment.sig>
