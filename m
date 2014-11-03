From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 03 Nov 2014 21:47:22 +0100
Subject: [PATCH 5/7] can: clear ctrlmode when close candev
In-Reply-To: <1414579527-31100-5-git-send-email-b29396@freescale.com>
References: <1414579527-31100-1-git-send-email-b29396@freescale.com>
 <1414579527-31100-5-git-send-email-b29396@freescale.com>
Message-ID: <5457E9DA.6090702@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2014 11:45 AM, Dong Aisheng wrote:
> Currently priv->ctrlmode is not cleared when close_candev, so next time
> the driver will still use this value to set controller even user
> does not set any ctrl mode.
> e.g.
> Step 1. ip link set can0 up type can0 bitrate 1000000 loopback on
> Controller will be in loopback mode
> Step 2. ip link set can0 down
> Step 3. ip link set can0 up type can0 bitrate 1000000
> Controller will still be set to loopback mode in driver due to saved
> priv->ctrlmode.
> 
> This patch clears priv->ctrlmode when the CAN interface is closed,
> and set it to correct mode according to next user setting.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

NACK, as discussed with Oliver.

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
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141103/b069e2e4/attachment.sig>
