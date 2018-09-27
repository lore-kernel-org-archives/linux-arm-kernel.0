From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 27 Sep 2018 10:58:37 +0200
Subject: [PATCH net-next] can: xilinx: fix return type of ndo_start_xmit
 function
In-Reply-To: <20180926103229.13204-1-yuehaibing@huawei.com>
References: <20180926103229.13204-1-yuehaibing@huawei.com>
Message-ID: <b364d678-98ea-2822-624d-3d65cccfc386@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2018 12:32 PM, YueHaibing wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, so make sure the implementation in
> this driver has returns 'netdev_tx_t' value, and change the function
> return type to netdev_tx_t.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

applied to can-next.

Tnx,
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
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180927/cd7ffd1e/attachment.sig>
